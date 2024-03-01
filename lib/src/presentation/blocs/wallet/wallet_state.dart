part of 'wallet_bloc.dart';

class WalletState {
  List<Graphic> graphics;
  WalletState(this.graphics);
}

class WalletInitial extends WalletState {
  WalletInitial(super.graphics);
}

class WalletStepperClientSelection extends WalletState {
  WalletStepperClientSelection(super.graphics);
}

class WalletStepperInvoiceSelection extends WalletState {
  WalletStepperInvoiceSelection(super.graphics);
}

class WalletStepperInvoiceAction extends WalletState {
  WalletStepperInvoiceAction(super.graphics);
}
