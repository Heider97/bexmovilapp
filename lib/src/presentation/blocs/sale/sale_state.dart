part of 'sale_bloc.dart';

enum SaleStatus { initial, loading, success, failed }

class SaleState extends Equatable {
  final SaleStatus status;
  final List<Section>? sections;
  final List<Router>? routers;
  final List<Client>? clients;

  final List<Filter>? filters;
  final String? error;

  const SaleState(
      {this.status = SaleStatus.initial,
      this.sections,
      this.routers,
      this.clients,
      this.filters,
      this.error});

  SaleState copyWith(
          {SaleStatus? status,
          List<Section>? sections,
          List<Router>? routers,
          List<Client>? clients,
          List<Filter>? filters,
          String? error}) =>
      SaleState(
          status: status ?? this.status,
          sections: sections ?? this.sections,
          routers: routers ?? this.routers,
          clients: clients ?? this.clients,
          filters: filters ?? this.filters,
          error: error ?? this.error);

  @override
  // TODO: implement props
  List<Object?> get props =>
      [status, sections, routers, clients, filters, error];
}
