part of 'wallet_bloc.dart';

enum WalletStatus {
  initial,
  loading,
  client,
  invoice,
  collection,
  success,
  failed
}

class WalletState extends Equatable {
  final WalletStatus status;
  final List<Graphic>? graphics;
  final List<Client>? clients;
  final List<Invoice>? invoices;
  final Client? client;
  final String? error;

  const WalletState(
      {this.status = WalletStatus.initial,
      this.graphics,
      this.clients,
      this.client,
      this.invoices,
      this.error});

  WalletState copyWith(
          {WalletStatus? status,
          List<Graphic>? graphics,
          List<Client>? clients,
          Client? client,
          List<Invoice>? invoices,
          String? error}) =>
      WalletState(
        status: status ?? this.status,
        graphics: graphics ?? this.graphics,
        clients: clients ?? this.clients,
        client: client ?? this.client,
        invoices: invoices ?? this.invoices,
        error: error ?? this.error,
      );

  @override
  List<Object?> get props => [
        status,
        graphics,
        clients,
        client,
        invoices,
        error,
      ];

  bool canRenderView() => status != WalletStatus.loading;
}
