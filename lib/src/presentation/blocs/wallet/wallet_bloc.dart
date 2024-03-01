import 'package:flutter_bloc/flutter_bloc.dart';
//domain
import '../../../domain/models/graphic.dart';
import '../../../domain/repositories/database_repository.dart';

//services
import '../../../services/storage.dart';
import '../../../services/navigation.dart';

part 'wallet_event.dart';
part 'wallet_state.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  final DatabaseRepository databaseRepository;
  final LocalStorageService storageService;
  final NavigationService navigationService;

  WalletBloc(
      this.databaseRepository, this.storageService, this.navigationService)
      : super(WalletInitial([])) {
    on<LoadGraphics>(_onLoadGraphics);
    on<SelectClientEvent>(_selectionEvent);
    on<InvoiceSelectionEvent>(_invoiceSelectionEvent);
    on<InvoiceActionEvent>(_invoiceActionEvent);
  }

  Future<void> _onLoadGraphics(LoadGraphics event, Emitter emit) async {
    var graphics = await databaseRepository.getAllGraphics();
    emit(WalletInitial(graphics));
  }

  _selectionEvent(SelectClientEvent event, Emitter emit) {
    emit(WalletStepperClientSelection(state.graphics));
  }

  _invoiceSelectionEvent(InvoiceSelectionEvent event, Emitter emit) {
    emit(WalletStepperInvoiceSelection(state.graphics));
  }

  _invoiceActionEvent(InvoiceActionEvent event, Emitter emit) {
    emit(WalletStepperInvoiceAction(state.graphics));
  }
}
