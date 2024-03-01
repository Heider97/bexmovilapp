part of 'sale_bloc.dart';

abstract class SaleState {
  List<Router> routers;
  List<Client> clients;

  SaleState(this.routers, this.clients);
}

class SaleInitial extends SaleState {
  SaleInitial(super.routers, super.clients);
}

class SaleClienteSelected extends SaleState {
  Client client;
  SaleClienteSelected(super.routers, super.clients, {required this.client});
}

class SaleProductSelected extends SaleState {
  List<Product> listOfProducts;
  SaleProductSelected(super.routers, super.clients,
      {required this.listOfProducts});
}

class SaleProductConfirm extends SaleState {
  List<Product> listOfProducts;
  SaleProductConfirm(super.routers, super.clients,
      {required this.listOfProducts});
}

class SaleOrderPreview extends SaleState {
  List<Product> listOfProducts;
  Client client;
  SaleOrderPreview(super.routers, super.clients,
      {required this.listOfProducts, required this.client});
}

class SaleOrderConfirm extends SaleState {
  List<Product> listOfProducts;
  Client client;
  SaleOrderConfirm(super.routers, super.clients,
      {required this.listOfProducts, required this.client});
}
