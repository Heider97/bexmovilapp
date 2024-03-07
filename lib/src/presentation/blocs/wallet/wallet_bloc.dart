import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//domain
import '../../../domain/models/graphic.dart';
import '../../../domain/models/client.dart';
import '../../../domain/models/invoice.dart';
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
    on<LoadClients>(_onLoadClients);
    on<LoadSummaries>(_onLoadSummaries);
    on<SelectInvoices>(_onSelectInvoices);
    on<Collection>(_onCollection);
  }

  Future<void> _onLoadGraphics(LoadGraphics event, Emitter emit) async {
    var graphics = await databaseRepository.getAllGraphics();
    emit(state.copyWith(status: WalletStatus.success, graphics: graphics));
  }

  Future<void> _onLoadClients(LoadClients event, Emitter emit) async {
    emit(state.copyWith(status: WalletStatus.loading));

    try {
      var seller = storageService.getString('username');
      var clients =
          await databaseRepository.getClientsByAgeRange(event.range!, seller!);

      emit(state.copyWith(status: WalletStatus.success, clients: clients));
    } catch (error, stackTrace) {
      emit(
          state.copyWith(status: WalletStatus.failed, error: error.toString()));
    }
  }

  Future<void> _onLoadSummaries(LoadSummaries event, Emitter emit) async {
    emit(state.copyWith(status: WalletStatus.loading));

    try {
      var seller = storageService.getString('username');
      var invoices = await databaseRepository.getInvoicesByClient(
          event.range!, seller!, event.client!.codeCliente!);

      print('**************');
      print(invoices);

      emit(state.copyWith(
          status: WalletStatus.success,
          client: event.client,
          invoices: invoices));
    } catch (error, stackTrace) {
      emit(
          state.copyWith(status: WalletStatus.failed, error: error.toString()));
    }
  }

  _onSelectInvoices(SelectInvoices event, Emitter emit) {
    //TODO: [Heider Zapa] get invoice from event and emit to state
    emit(state.copyWith(status: WalletStatus.invoice));
  }

  _onCollection(Collection event, Emitter emit) {
    //TODO: [Heider Zapa] get action invoice from event and emit to state
    emit(state.copyWith(status: WalletStatus.collection));
  }
}
