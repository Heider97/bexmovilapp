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

class SelectWarehouse extends SaleEvent {
  final Warehouse? warehouse;
  SelectWarehouse({required this.warehouse});
}

class SelectPriceList extends SaleEvent {
  final Price? listPriceSelected;
  SelectPriceList({required this.listPriceSelected});
}

class GridModeChange extends SaleEvent {
  final bool changeMode;
  GridModeChange({required this.changeMode});
}

class SelectProduct extends SaleEvent {
  final Product? product;
  SelectProduct({required this.product});
}
