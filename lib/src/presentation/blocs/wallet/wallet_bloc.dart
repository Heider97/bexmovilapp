import 'dart:async';

import 'package:equatable/equatable.dart';
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

  // Create a broadcast controller that allows this stream to be listened
  // to multiple times. This is the primary, if not only, type of stream you'll be using.
  final _notesController = StreamController<bool>.broadcast();

  // Input stream. We add our notes to the stream using this variable.
  StreamSink<bool> get _inNotes => _notesController.sink;

  // Output stream. This one will be used within our pages to display the notes.
  Stream<bool> get notes => _notesController.stream;

  // Input stream for adding new notes. We'll call this from our pages.
  final _addNoteController = StreamController<bool>.broadcast();
  StreamSink<bool> get inAddNote => _addNoteController.sink;

  WalletBloc(
      this.databaseRepository, this.storageService, this.navigationService)
      : super(const WalletState(status: WalletStatus.initial)) {
    on<LoadGraphics>(_onLoadGraphics);
    on<SelectClientEvent>(_selectionEvent);
    on<InvoiceSelectionEvent>(_invoiceSelectionEvent);
    on<InvoiceActionEvent>(_invoiceActionEvent);
  }

  // Stream<int> listenForTrigger = Stream.periodic(const Duration(seconds: 1), (int result) {
  //   return databaseRepository.listenForTableChanges(null) == true ? 1 : 0;
  // });

  Future<void> _onLoadGraphics(LoadGraphics event, Emitter emit) async {
    var graphics = await databaseRepository.getAllGraphics();
    emit(state.copyWith(status: WalletStatus.success, graphics: graphics));
  }

  _selectionEvent(SelectClientEvent event, Emitter emit) {
    //TODO: [Heider Zapa] get client from event and emit to state
    emit(state.copyWith(status: WalletStatus.success));
  }

  _invoiceSelectionEvent(InvoiceSelectionEvent event, Emitter emit) {
    //TODO: [Heider Zapa] get invoice from event and emit to state
    emit(state.copyWith(status: WalletStatus.success));
  }

  _invoiceActionEvent(InvoiceActionEvent event, Emitter emit) {
    //TODO: [Heider Zapa] get action invoice from event and emit to state
    emit(state.copyWith(status: WalletStatus.success));
  }
}
