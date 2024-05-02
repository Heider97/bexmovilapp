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
  final List<Warehouse>? availableWarehouse;
  final Warehouse? selectedWarehouse;
  final String? idListPrice;
  final List<Section>? sections;
  final List<Router>? routers;
  final List<Client>? clients;
  final List<Client>? clientsFounded;
  final List<Filter>? filters;
  final Router? selectedRouter;

  final bool? gridView;

  final String? error;

  const SaleState(
      {this.status = SaleStatus.initial,
      this.sections,
      this.availableWarehouse,
      this.selectedWarehouse,
      this.idListPrice,
      this.routers,
      this.clients,
      this.clientsFounded,
      this.filters,
      this.gridView,
      this.error,
      this.selectedRouter});

  SaleState copyWith(
          {SaleStatus? status,
          List<Section>? sections,
          List<Router>? routers,
          List<Client>? clients,
          List<Client>? clientsFounded,
          List<Filter>? filters,
          Warehouse? selectedWarehouse,
          List<Warehouse>? availableWarehouse,
          String? idListPrice,
          bool? gridView,
          String? error,
          Router? selectedRouter}) =>
      SaleState(
          status: status ?? this.status,
          sections: sections ?? this.sections,
          routers: routers ?? this.routers,
          clients: clients ?? this.clients,
          clientsFounded: clientsFounded ?? this.clientsFounded,
          filters: filters ?? this.filters,
          gridView: gridView ?? this.gridView,
          error: error ?? this.error,
          selectedRouter: selectedRouter ?? this.selectedRouter,
          selectedWarehouse: selectedWarehouse ?? this.selectedWarehouse,
          idListPrice: idListPrice ?? this.idListPrice,
          availableWarehouse: availableWarehouse ?? this.availableWarehouse);

  @override
  // TODO: implement props
  List<Object?> get props =>
      [status, sections, routers, clients, filters, error];
}
