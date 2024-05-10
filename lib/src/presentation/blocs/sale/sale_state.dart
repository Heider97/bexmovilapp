part of 'sale_bloc.dart';

enum SaleStatus {
  initial,
  loading,
  routers,
  clients,
  warehouses,
  products,
  failed
}

class SaleState {
  final SaleStatus status;

  final List<Section>? sections;
  final List<Router>? routers;
  final List<Client>? clients;
  final List<Client>? clientsFounded;
  final List<Filter>? filters;
  final List<Warehouse>? warehouseList;
  final List<Price>? priceList;

  final Router? selectedRouter;
  final Client? selectedClient;
  final Warehouse? selectedWarehouse;
  final Price? selectedPrice;

//ID CLIENTE - ID PRODUCTO Y STCOK
  //final List<Map<String, String>>? product;

  final bool? gridView;

  final String? error;

  const SaleState(
      {this.status = SaleStatus.initial,
      this.sections,
      this.warehouseList,
      this.selectedWarehouse,
      this.priceList,
      this.selectedPrice,
      this.routers,
      this.clients,
      this.clientsFounded,
      this.selectedClient,
      this.filters,
      this.gridView,
      this.error,
      this.selectedRouter});

  SaleState copyWith({
    SaleStatus? status,
    List<Section>? sections,
    List<Router>? routers,
    List<Client>? clients,
    List<Client>? clientsFounded,
    List<Filter>? filters,
    List<Warehouse>? warehouseList,
    Warehouse? selectedWarehouse,
    List<Map<String, Product>>? product,
    List<Price>? priceList,
    Client? selectedClient,
    Price? selectedPrice,
    bool? gridView,
    String? error,
    Router? selectedRouter,
  }) =>
      SaleState(
        status: status ?? this.status,
        sections: sections ?? this.sections,
        routers: routers ?? this.routers,
        clients: clients ?? this.clients,
        clientsFounded: clientsFounded ?? this.clientsFounded,
        selectedClient: selectedClient ?? this.selectedClient,
        filters: filters ?? this.filters,
        gridView: gridView ?? this.gridView,
        //product: product ?? this.product,
        error: error ?? this.error,
        selectedRouter: selectedRouter ?? this.selectedRouter,
        warehouseList: warehouseList ?? this.warehouseList,
        selectedWarehouse: selectedWarehouse ?? this.selectedWarehouse,
        priceList: priceList ?? this.priceList,
        selectedPrice: selectedPrice ?? this.selectedPrice,
      );

  List<Object?> get props =>
      [status, sections, routers, clients, filters, error];
}
