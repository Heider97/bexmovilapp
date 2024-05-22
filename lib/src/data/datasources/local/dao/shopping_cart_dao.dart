import 'package:bexmovil/src/data/datasources/local/app_database.dart';
import 'package:bexmovil/src/domain/models/product.dart';
import 'package:bexmovil/src/locator.dart';
import 'package:bexmovil/src/services/query_loader.dart';
import 'package:bexmovil/src/services/storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final LocalStorageService storageService = locator<LocalStorageService>();
final QueryLoaderService queryLoaderService = locator<QueryLoaderService>();

class ShoppingCartDao {
  final AppDatabase _appDatabase;

  ShoppingCartDao(this._appDatabase);

  Future<List<String>> getProductsByRouterAndClient(
      String codrouter, String codcliente) async {
    final db = await _appDatabase.database;

    List<Map<String, dynamic>> result = await db!.query(
      'app_cart',
      columns: ['codproducts'],
      where: 'codrouter = ? AND codcliente = ?',
      whereArgs: [codrouter, codcliente],
    );

    List<String> products = [];
    for (var row in result) {
      // Assuming codproducts is a comma-separated string of product IDs
      products.addAll((row['codproducts'] as String).split(','));
    }

    return products;
  }

  Future<int> getStockByProduct(String productId, String cartId) async {
    final db = await _appDatabase.database;

    List<Map<String, dynamic>> result = await db!.rawQuery(
      'SELECT SUM(quantity) as total_stock FROM app_cart_stock WHERE product_id = ? AND cart_id = ?',
      [productId,cartId],
    );

    if (result.isNotEmpty) {
      return result.first['total_stock'] as int;
    } else {
      return 0;
    }
  }

  Future<double> getTotalProductValue(
    String codrouter,
    String codPrecio,
    String codBodega,
    String codcliente,
  ) async {
    final db = await _appDatabase.database;

    // Primero, obtener los cart_id correspondientes
    List<Map<String, dynamic>> cartIds = await db!.query(
      'app_cart',
      columns: ['id'],
      where:
          'codrouter = ? AND codPrecio = ? AND codBodega = ? AND codcliente = ?',
      whereArgs: [codrouter, codPrecio, codBodega, codcliente],
    );

    // Si no hay resultados, devolver 0
    if (cartIds.isEmpty) {
      return 0;
    }

    // Crear una lista de cart_ids para usar en la siguiente consulta
    List<int> cartIdList = cartIds.map((cart) => cart['id'] as int).toList();

    // Consulta para sumar todas las cantidades de la columna 'quantity' para los cart_ids especificados
    String cartIdString = cartIdList.join(',');
    var quantityResult = await db.rawQuery(
        'SELECT product_id, SUM(quantity) as total FROM app_cart_stock WHERE cart_id IN ($cartIdString) GROUP BY product_id');

    if (quantityResult.isEmpty) {
      return 0;
    }

    double totalValue = 0;

    for (var row in quantityResult) {
      String productId = row['product_id'] as String;
      int totalQuantity = (row['total'] ?? 0) as int;

      // Obtener el precio del producto basado en CODPRODUCTO
      List<Map<String, dynamic>> priceResult = await db.query(
        'tbldproductoprecio',
        columns: ['precioproductoprecio'],
        where: 'CODPRODUCTO = ?',
        whereArgs: [productId],
      );

      if (priceResult.isEmpty) {
        throw Exception('Product not found for CODPRODUCTO: $productId');
      }

// Convertir el precio del producto a double
      num precioProductoNum = priceResult.first['precioproductoprecio'];
      double precioProducto = precioProductoNum.toDouble();
     

      // Calcular el valor total del producto
      totalValue += precioProducto * totalQuantity;
    }

    return totalValue;
  }

  Future<CartProductInfo> getCartProductInfo(
    String codrouter,
    String codcliente,
    String codPrecio,
    String codBodega,
  ) async {
    final db = await _appDatabase.database;
    // Obtener los productos del carrito por codRouter y codCliente
    List<Map<String, dynamic>> cartResults = await db!.query(
      'app_cart',
      columns: ['id', 'codproducts'],
      where: 'codrouter = ? AND codcliente = ? AND codPrecio = ? AND codBodega = ?',
      whereArgs: [codrouter, codcliente, codPrecio, codBodega],
    );

    

    if (cartResults.isEmpty) {
      throw Exception('No cart found for the given codRouter and codCliente');
    }

    // Asumimos que solo hay un carrito por codRouter y codCliente
    var cartRow = cartResults.first;
    String cartId = cartRow['id'].toString();
    List<String> productIds = (cartRow['codproducts'] as String).split(',');

    // Obtener los productos y su información
    List<ProductCart> productCarts = [];
    for (String productId in productIds) {
      // Obtener la información del producto por su ID
      Product product = await getProductById(productId, codPrecio, codBodega);
      // Obtener el stock del producto
      int stock = await getStockByProduct(productId,cartId);
      // Crear un objeto ProductCart
      productCarts.add(ProductCart(product: product, stock: stock));
    }

    return CartProductInfo(
        cartId: cartId,
        codRouter: codrouter,
        codClient: codcliente,
        products: productCarts,
        codBodega: codBodega,
        codPrecio: codPrecio);
  }

  Future<Product> getProductById(
      String productId, String codPrecio, String codBodega) async {
    var seller = storageService.getString('username');
    var products = <Product>[];

    Map<String, dynamic> variables = await queryLoaderService.load(
        '/sale-products',
        'SaleBloc',
        'LoadProducts',
        seller!,
        [codPrecio, codBodega]);

    List<String> keys = variables.keys.toList();

    for (var i = 0; i < variables.length; i++) {
      if (keys[i] == 'products') {
        products = variables[keys[i]];
      }
    }

    for (Product producto in products) {
      if (producto.codProducto == productId) {
        return producto;
      }
    }
    // Si no se encuentra el producto, lanzar una excepción
    throw Exception('Product with ID $productId not found');
  }

  Future<void> insertCart(
    String codrouter,
    String codPrecio,
    String codBodega,
    String codcliente,
    String codproducts,
    int quantity,
    String state,
    String date,
  ) async {
    final db = await _appDatabase.database;

    // Verificar si ya existe un registro con los valores especificados
    List<Map<String, dynamic>> existingCarts = await db!.query(
      'app_cart',
      where:
          'codrouter = ? AND codPrecio = ? AND codBodega = ? AND codcliente = ?',
      whereArgs: [codrouter, codPrecio, codBodega, codcliente],
    );

    if (existingCarts.isNotEmpty) {
      // Actualizar el registro existente
      Map<String, dynamic> existingCart = existingCarts.first;
      int cartId = existingCart['id'];

      // Verificar si el producto ya está en la lista
      List<String> productList = existingCart['codproducts'].split(',');
      if (!productList.contains(codproducts)) {
        productList.add(codproducts);
      }
      String updatedCodproducts = productList.join(',');

      // Actualizar los campos codproducts y date
      await db.update(
        'app_cart',
        {
          'codproducts': updatedCodproducts,
          'date': date,
        },
        where: 'id = ?',
        whereArgs: [cartId],
      );

      // Actualizar el stock
      await insertCartStock(cartId, codproducts, quantity);
    } else {
      // Insertar un nuevo registro
      Map<String, dynamic> cart = {
        'codrouter': codrouter,
        'codPrecio': codPrecio,
        'codBodega': codBodega,
        'codcliente': codcliente,
        'codproducts': codproducts,
        'state': state,
        'date': date,
      };

      int cartId = await db.insert('app_cart', cart);
      await insertCartStock(cartId, codproducts, quantity);
    }
  }

  Future<void> insertCartStock(
      int cartId, String productId, int quantity) async {
    final db = await _appDatabase.database;

    // Verificar si ya existe el producto en la tabla app_cart_stock para el cart_id especificado
    List<Map<String, dynamic>> existingStock = await db!.query(
      'app_cart_stock',
      where: 'cart_id = ? AND product_id = ?',
      whereArgs: [cartId, productId],
    );

    if (existingStock.isNotEmpty) {
      // Si el producto ya existe, actualizar la cantidad sumando la nueva cantidad
      Map<String, dynamic> stock = existingStock.first;
      int newQuantity = stock['quantity'] + quantity;
      await db.update(
        'app_cart_stock',
        {'quantity': newQuantity},
        where: 'cart_id = ? AND product_id = ?',
        whereArgs: [cartId, productId],
      );
    } else {
      // Si el producto no existe, insertar un nuevo registro
      Map<String, dynamic> cartStock = {
        'cart_id': cartId,
        'product_id': productId,
        'quantity': quantity,
      };
      await db.insert('app_cart_stock', cartStock);
    }
  }

  Future<int> getTotalProductQuantity(
    String codrouter,
    String codPrecio,
    String codBodega,
    String codcliente,
  ) async {
    final db = await _appDatabase.database;

    // Primero, obtener los cart_id correspondientes
    List<Map<String, dynamic>> cartIds = await db!.query(
      'app_cart',
      columns: ['id'],
      where:
          'codrouter = ? AND codPrecio = ? AND codBodega = ? AND codcliente = ?',
      whereArgs: [codrouter, codPrecio, codBodega, codcliente],
    );

    // Si no hay resultados, devolver 0
    if (cartIds.isEmpty) {
      return 0;
    }

    // Crear una lista de cart_ids para usar en la siguiente consulta
    List<int> cartIdList = cartIds.map((cart) => cart['id'] as int).toList();

    // Consulta para sumar todas las cantidades de la columna 'quantity' para los cart_ids especificados
    String cartIdString = cartIdList.join(',');
    var result = await db.rawQuery(
        'SELECT SUM(quantity) as total FROM app_cart_stock WHERE cart_id IN ($cartIdString)');

    int totalQuantity = (result.first['total'] ?? 0) as int;
    return totalQuantity;
  }
}
