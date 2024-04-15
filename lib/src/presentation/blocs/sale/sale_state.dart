part of 'sale_bloc.dart';

enum SaleStatus { initial, loading, success, failed }

class SaleState extends Equatable {
  final SaleStatus status;
  final List<Section>? sections;
  final List<Router>? routers;
  final List<Client>? clients;
  final List<Client>? clientsFounded;
  final List<Filter>? filters;

  final bool? gridView;

  final String? error;

  const SaleState(
      {this.status = SaleStatus.initial,
      this.sections,
      this.routers,
      this.clients,
      this.clientsFounded,
      this.filters,
      this.gridView,
      this.error});

  SaleState copyWith(
          {SaleStatus? status,
          List<Section>? sections,
          List<Router>? routers,
          List<Client>? clients,
          List<Client>? clientsFounded,
          List<Filter>? filters,
          bool? gridView,
          String? error}) =>
      SaleState(
          status: status ?? this.status,
          sections: sections ?? this.sections,
          routers: routers ?? this.routers,
          clients: clients ?? this.clients,
          clientsFounded: clientsFounded ?? this.clientsFounded,
          filters: filters ?? this.filters,
          gridView: gridView ?? this.gridView,
          error: error ?? this.error);

  @override
  // TODO: implement props
  List<Object?> get props =>
      [status, sections, routers, clients, filters, error];
}
