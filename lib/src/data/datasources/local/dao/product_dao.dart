/* part of '../app_database.dart';

class ProductDao {
  final AppDatabase _appDatabase;

  ProductDao(this._appDatabase);

  List<Product> parseProducts(List<Map<String, dynamic>> productList) {
    final products = <Product>[];
    for (var productMap in productList) {
      final product = Product.fromMap(productMap);
      products.add(product);
    }
    return products;
  }

  Future<List<Product>> getAllProducts() async {
    final db = await _appDatabase.streamDatabase;
    final productList = await db!.query(tableProducts);
    final products = parseProducts(productList);
    return products;
  }

  Future<Product> getProduct(int productId) async {
    final db = await _appDatabase.streamDatabase;
    final productList = await db!.query(tableProducts, where: 'id = ?', whereArgs: [productId]);
    final products = parseProducts(productList);
    return products.first;
  }

  Future<int> insertProduct(Product product) {
    return _appDatabase.insert(tableProducts, product.toMap());
  }

  Future<void> insertProducts(List<Product> products) async {
    final db = await _appDatabase.streamDatabase;
    var batch = db!.batch();

    await Future.forEach(products, (product) async {
        var foundProduct = await db.query(tableProducts, where: 'name = ?', whereArgs: [product.name]);

        if(foundProduct.isNotEmpty){
          batch.update(tableProducts, product.toMap(), where: 'name = ?', whereArgs: [product.name]);
        } else {
          batch.insert(tableProducts, product.toMap());
        }
    });


    batch.commit(noResult: true, continueOnError: true);
  }

  Future<int> updateProduct(Product product) {
    return _appDatabase.update(
        tableProducts, product.toMap(), 'id', product.id);
  }

  Future<void> emptyProducts() async {
    final db = await _appDatabase.streamDatabase;
    await db!.delete(tableProducts);
    return Future.value();
  }
}
 */