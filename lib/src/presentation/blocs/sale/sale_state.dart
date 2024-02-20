part of 'sale_bloc.dart';

abstract class SaleState {
  List<Router> routers;

  SaleState(this.routers);
}

class SaleInitial extends SaleState {
  SaleInitial(super.routers);
}

class SaleClienteSelected extends SaleState {
  Client client;
  SaleClienteSelected(super.routers, {required this.client});
}

class SaleProductSelected extends SaleState {
  List<Product> listOfProducst;
  SaleProductSelected(super.routers, {required this.listOfProducst});
}

class SaleProductConfirm extends SaleState {
  List<Product> listOfProducst;
  SaleProductConfirm(super.routers, {required this.listOfProducst});
}

class SaleOrderPreview extends SaleState {
  List<Product> listOfProducst;
  Client client;
  SaleOrderPreview(super.routers, {required this.listOfProducst, required this.client});
}

class SaleOrderConfirm extends SaleState {
  List<Product> listOfProducst;
  Client client;
  SaleOrderConfirm(super.routers, {required this.listOfProducst, required this.client});
}
