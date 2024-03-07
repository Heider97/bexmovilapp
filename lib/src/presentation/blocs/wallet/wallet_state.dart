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
  final Client? client;
  final String? error;

  const WalletState(
      {this.status = WalletStatus.initial,
      this.graphics,
      this.clients,
      this.client,
      this.error});

  WalletState copyWith(
          {WalletStatus? status,
          List<Graphic>? graphics,
          List<Client>? clients,
          Client? client,
          String? error}) =>
      WalletState(
        status: status ?? this.status,
        graphics: graphics ?? this.graphics,
        clients: clients ?? this.clients,
        client: client ?? this.client,
        error: error ?? this.error,
      );

  @override
  List<Object?> get props => [
        status,
        graphics,
        clients,
        client,
        error,
      ];

  bool canRenderView() => status != WalletStatus.loading;
}
