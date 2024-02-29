import 'package:flutter_bloc/flutter_bloc.dart';

part 'wallet_event.dart';
part 'wallet_state.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  WalletBloc() : super(WalletInitial()) {
    on<SelectClientEvent>(_selectionEvent);
    on<InvoiceSelectionEvent>(_invoiceSelectionEvent);
    on<InvoiceActionEvent>(_invoiceActionEvent);
  }
  _selectionEvent(SelectClientEvent event, Emitter emit) {
    emit(WalletStepperClientSelection());
  }

  _invoiceSelectionEvent(InvoiceSelectionEvent event, Emitter emit) {
    emit(WalletStepperInvoiceSelection());
  }

  _invoiceActionEvent(InvoiceActionEvent event, Emitter emit) {
    emit(WalletStepperInvoiceAction());
  }
}
