part of 'wallet_bloc.dart';

class WalletEvent {}

class SelectClientEvent extends WalletEvent {
  SelectClientEvent();
}

class LoadGraphics extends WalletEvent {}

class InvoiceSelectionEvent extends WalletEvent {
  InvoiceSelectionEvent();
}

class InvoiceActionEvent extends WalletEvent {
  InvoiceActionEvent();
}