part of 'sale_bloc.dart';

class SaleEvent {
  const SaleEvent();
}


class LoadRouters extends SaleEvent {}

class LoadClients extends SaleEvent {}

class SelectClient extends SaleEvent {
  final Client client;
  SelectClient({required this.client});
}

class SelectProducts extends SaleEvent {
  final Product product;
  SelectProducts({required this.product});
}

class ConfirmProducts extends SaleEvent {
  final List<Product> products;
  ConfirmProducts({required this.products});
}

class ConfirmOrder extends SaleEvent {
  final List<Product> products;
  final Client client;
  ConfirmOrder({required this.products, required this.client});
}
