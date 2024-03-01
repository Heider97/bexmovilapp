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
  SaleClienteSelected(super.routers,super.clients, {required this.client});
}

// class SaleProductSelected extends SaleState {
//   List<Product> listOfProducst;
//   SaleProductSelected(super.routers,super.clients, {required this.listOfProducst});
// }
//
// class SaleProductConfirm extends SaleState {
//   List<Product> listOfProducst;
//   SaleProductConfirm(super.routers, super.clients, {required this.listOfProducst});
// }
//
// class SaleOrderPreview extends SaleState {
//   List<Product> listOfProducst;
//   Client client;
//   SaleOrderPreview(super.routers, super.clients, {required this.listOfProducst, required this.client});
// }
//
// class SaleOrderConfirm extends SaleState {
//   List<Product> listOfProducst;
//   Client client;
//   SaleOrderConfirm(super.routers, super.clients, {required this.listOfProducst, required this.client});
// }
