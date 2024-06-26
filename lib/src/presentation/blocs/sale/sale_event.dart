part of 'sale_bloc.dart';

class SaleEvent {
  const SaleEvent();
}

class LoadRouters extends SaleEvent {}

class LoadClients extends SaleEvent {
  final Router? router;
  LoadClients(this.router);
}

class SearchClient extends SaleEvent {
  final String? value;
  SearchClient(this.value);
}

class NavigationSale extends SaleEvent {
  final bool nearest;
  final List<Client> clients;
  NavigationSale({required this.clients, required this.nearest});
}

class SearchClientSale extends SaleEvent {
  final String valueToSearch;
  SearchClientSale({required this.valueToSearch});
}

class LoadWarehousesAndPrices extends SaleEvent {
  final Client? client;
  final Router? router;

  final String? codbodega;
  final String? codprecio;
  final String navigation;

  LoadWarehousesAndPrices(
      {this.client,
      this.router,
      this.codprecio,
      this.codbodega,
      required this.navigation});
}

class SelectWarehouse extends SaleEvent {
  final Warehouse? warehouse;
  SelectWarehouse({required this.warehouse});
}

class SelectPriceList extends SaleEvent {
  final Price? listPriceSelected;
  SelectPriceList({required this.listPriceSelected});
}

class LoadProducts extends SaleEvent {
  final Client? client;
  final Router? router;
  final Warehouse? warehouse;
  final Price? price;

  final String? codbodega;
  final String? codprecio;

  LoadProducts(this.client, this.router, this.warehouse, this.price,
      this.codbodega, this.codprecio);
}

class SearchProduct extends SaleEvent {
  final String? value;
  SearchProduct(this.value);
}

class GridModeChange extends SaleEvent {
  final String grid;
  GridModeChange({required this.grid});
}

class SelectProduct extends SaleEvent {
  final Product? product;
  SelectProduct({required this.product});
}

class LoadCart extends SaleEvent {
  LoadCart();
}

class GetDetailsShippingCart extends SaleEvent {
  GetDetailsShippingCart();
}

class GetProductsShippingCart extends SaleEvent {
  GetProductsShippingCart();
}

class DisposeShippingCart extends SaleEvent {
  DisposeShippingCart();
}

class RemoveItemCart extends SaleEvent {
  final String codProduct;
  RemoveItemCart({required this.codProduct});
}

class OrderProductsBy extends SaleEvent {
  final OrderOption orderOption;
  OrderProductsBy({required this.orderOption});
}

class LoadProductsPaginated extends SaleEvent {
  final String codprecio, codbodega;
  final int offset, limit;
  LoadProductsPaginated(
      {required this.codprecio,
      required this.codbodega,
      required this.offset,
      required this.limit});
}
