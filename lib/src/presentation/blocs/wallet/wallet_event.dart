part of 'wallet_bloc.dart';

class WalletEvent {}

class SelectClientEvent extends WalletEvent {
  SelectClientEvent();
}

class LoadGraphics extends WalletEvent {}

class LoadClients extends WalletEvent {
  final String? range;
  LoadClients({ this.range  });
}

class LoadSummaries extends WalletEvent {
  final String? range;
  final Client? client;
  LoadSummaries({ this.range, this.client  });
}

class SelectInvoices extends WalletEvent {
  // final List<Invoices> invoices;
  SelectInvoices();
}

class Collection extends WalletEvent {
  Collection();
}
