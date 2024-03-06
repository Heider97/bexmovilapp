part of 'sale_bloc.dart';

class SaleEvent {
  const SaleEvent();
}

class LoadRouters extends SaleEvent {}

class LoadClients extends SaleEvent {
  final String? codeRouter;
  LoadClients(this.codeRouter);
}

class SelectClient extends SaleEvent {
  final Client client;
  SelectClient({required this.client});
}

class NavigationSale extends SaleEvent {
  final bool nearest;
  final List<Client> clients;
  NavigationSale({required this.clients, required this.nearest});
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
