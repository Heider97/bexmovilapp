part of 'sale_bloc.dart';

enum SaleStatus { initial, loading, success, failed }

class SaleState extends Equatable {
  final SaleStatus status;
  final List<Router>? routers;
  final List<Client>? clients;
  final String? error;

  const SaleState(
      {this.status = SaleStatus.initial,
      this.routers,
      this.clients,
      this.error});

  SaleState copyWith(
          {SaleStatus? status,
          List<Router>? routers,
          List<Client>? clients,
          String? error}) =>
      SaleState(
          status: status ?? this.status,
          routers: routers ?? this.routers,
          clients: clients ?? this.clients,
          error: error ?? this.error);

  @override
  // TODO: implement props
  List<Object?> get props => [status, routers, clients, error];
}

class SaleInitial extends SaleState {
  SaleInitial();
}

// class SaleClienteSelected extends SaleState {
//   Client client;
//   SaleClienteSelected(super.routers,super.clients, {required this.client});
// }
