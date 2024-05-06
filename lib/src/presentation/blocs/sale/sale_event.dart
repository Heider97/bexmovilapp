part of 'sale_bloc.dart';

class SaleEvent {
  const SaleEvent();
}

class LoadRouters extends SaleEvent {}

class LoadClients extends SaleEvent {
  final String? codeRouter;
  LoadClients(this.codeRouter);
}

class LoadWarehouses extends SaleEvent {
  final int? codcliente;
  final String? codbodega;
  final String? codprecio;

  LoadWarehouses({ this.codcliente, this.codprecio, this.codbodega });
}

class LoadProducts extends SaleEvent {
  final String? codbodega;
  final String? codprecio;

  LoadProducts(this.codbodega, this.codprecio);
}

class ResetStatus extends SaleEvent {
  final SaleStatus status;
  ResetStatus({required this.status});
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

class GridModeChange extends SaleEvent {
  final bool changeMode;
  GridModeChange({required this.changeMode});
}

class SelectRouter extends SaleEvent {
  final Router router;
  SelectRouter({required this.router});
}

class SelectWarehouseAndListPrice extends SaleEvent {
  String idListPrice;
  String idWarehouse;
  SelectWarehouseAndListPrice(
      {required this.idListPrice, required this.idWarehouse});
}

class LoadWarehouseAndListPrice extends SaleEvent {
  String? codeClient;
  LoadWarehouseAndListPrice(/* {required this.codeClient} */);
}

class SelectWarehouse extends SaleEvent {
  final Warehouse? warehouse;
  SelectWarehouse({required this.warehouse});
}

class SelectPriceList extends SaleEvent {
  final Price? listPriceSelected;
  SelectPriceList({required this.listPriceSelected});
}






//
// class SelectProducts extends SaleEvent {
//   final Product product;
//   SelectProducts({required this.product});
// }
//
// class ConfirmProducts extends SaleEvent {
//   final List<Product> products;
//   ConfirmProducts({required this.products});
// }
//
// class ConfirmOrder extends SaleEvent {
//   final List<Product> products;
//   final Client client;
//   ConfirmOrder({required this.products, required this.client});
// }
