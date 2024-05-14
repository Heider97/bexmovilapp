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
  final List<Router>? routers;
  final Router? router;
  final List<Client>? clients;
  final List<Client>? clientsFounded;
  final Client? client;
  final List<Filter>? filters;
  final List<Warehouse>? warehouses;
  final Warehouse? warehouse;
  final List<Price>? prices;
  final Price? price;
  final List<Product>? products;

  //ID CLIENTE - ID PRODUCTO Y STCOK
  //final List<Map<String, String>>? product;

  final bool? gridView;

  final String? error;

  const SaleState({
    this.status = SaleStatus.initial,
    this.routers,
    this.router,
    this.clients,
    this.clientsFounded,
    this.client,
    this.filters,
    this.warehouses,
    this.warehouse,
    this.prices,
    this.price,
    this.products,
    this.gridView,
    this.error,
  });

  SaleState copyWith({
    SaleStatus? status,
    List<Router>? routers,
    Router? router,
    List<Client>? clients,
    Client? client,
    List<Client>? clientsFounded,
    List<Filter>? filters,
    List<Warehouse>? warehouses,
    Warehouse? warehouse,
    List<Price>? prices,
    Price? price,
    List<Product>? products,
    List<Map<String, Product>>? product,
    bool? gridView,
    String? error,
  }) =>
      SaleState(
        status: status ?? this.status,
        routers: routers ?? this.routers,
        router: router ?? this.router,
        clients: clients ?? this.clients,
        clientsFounded: clientsFounded ?? this.clientsFounded,
        client: client ?? this.client,
        filters: filters ?? this.filters,
        warehouses: warehouses ?? this.warehouses,
        warehouse: warehouse ?? this.warehouse,
        prices: prices ?? this.prices,
        price: price ?? this.price,
        products: products ?? this.products,
        gridView: gridView ?? this.gridView,
        //product: product ?? this.product,
        error: error ?? this.error,
      );

  List<Object?> get props => [status, routers, clients, filters, error];
}
