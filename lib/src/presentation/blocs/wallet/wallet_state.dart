part of 'wallet_bloc.dart';

enum WalletStatus {
  initial,
  loading,
  dashboard,
  clients,
  invoices,
  collection,
  failed
}

class WalletState extends Equatable {
  final WalletStatus status;
  final List<Section>? sections;
  final List<dynamic>? graphics;
  final List<Client>? clients;
  final List<Invoice>? invoices;
  final String? age;
  final Client? client;
  final String? error;

  const WalletState(
      {this.status = WalletStatus.initial,
      this.sections,
      this.graphics,
      this.clients,
      this.age,
      this.client,
      this.invoices,
      this.error});

  WalletState copyWith(
          {WalletStatus? status,
          List<Section>? sections,
          List<Graphic>? graphics,
          List<Client>? clients,
          String? age,
          Client? client,
          List<Invoice>? invoices,
          String? error}) =>
      WalletState(
        status: status ?? this.status,
        sections: sections ?? this.sections,
        graphics: graphics ?? this.graphics,
        clients: clients ?? this.clients,
        age: age ?? this.age,
        client: client ?? this.client,
        invoices: invoices ?? this.invoices,
        error: error ?? this.error,
      );

  @override
  List<Object?> get props => [
        status,
        sections,
        graphics,
        clients,
        client,
        invoices,
        error,
      ];

  bool canRenderView() => status != WalletStatus.loading;
}
