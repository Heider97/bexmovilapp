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

class SearchClientWallet extends WalletEvent {
  final String valueToSearch;
  SearchClientWallet({required this.valueToSearch});
}

class LoadSummaries extends WalletEvent {
  final String? range;
  final Client? client;
  LoadSummaries({ this.range, this.client  });
}

class SearchSummaryWallet extends WalletEvent {
  final String valueToSearch;
  SearchSummaryWallet({required this.valueToSearch});
}

class SelectInvoices extends WalletEvent {
  // final List<Invoices> invoices;
  SelectInvoices();
}

class Collection extends WalletEvent {
  Collection();
}
