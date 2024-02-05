part of 'sale_bloc.dart';

abstract class SaleState {}

class SaleInitial extends SaleState {}

class SaleClienteSelected extends SaleState {
  Client client;
  SaleClienteSelected({required this.client});
}

class SaleProductSelected extends SaleState {
  List<Product> listOfProducst;
  SaleProductSelected({required this.listOfProducst});
}

class SaleProductConfirm extends SaleState {
  List<Product> listOfProducst;
  SaleProductConfirm({required this.listOfProducst});
}

class SaleOrderPreview extends SaleState {
  List<Product> listOfProducst;
  Client client;
  SaleOrderPreview({required this.listOfProducst, required this.client});
}

class SaleOrderConfirm extends SaleState {
  List<Product> listOfProducst;
  Client client;
  SaleOrderConfirm({required this.listOfProducst, required this.client});
}
