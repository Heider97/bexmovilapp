import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//domain
import '../../../domain/models/graphic.dart';
import '../../../domain/models/client.dart';
import '../../../domain/models/invoice.dart';
import '../../../domain/models/section.dart';
import '../../../domain/repositories/database_repository.dart';

//services
import '../../../services/query_loader.dart';
import '../../../services/storage.dart';
import '../../../services/navigation.dart';

part 'wallet_event.dart';
part 'wallet_state.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  final DatabaseRepository databaseRepository;
  final LocalStorageService storageService;
  final NavigationService navigationService;
  final QueryLoaderService queryLoaderService;

  WalletBloc(this.databaseRepository, this.storageService,
      this.navigationService, this.queryLoaderService)
      : super(const WalletState(status: WalletStatus.initial)) {
    on<LoadGraphics>(_onLoadGraphics);
    on<LoadClients>(_onLoadClients);
    on<LoadSummaries>(_onLoadSummaries);
    on<SelectInvoices>(_onSelectInvoices);
    on<Collection>(_onCollection);
    on<SelectClientEvent>(_selectClientEvent);
  }

  _selectClientEvent(SelectClientEvent event, Emitter emit) {
    //
  }

  Future<void> _onLoadGraphics(LoadGraphics event, Emitter emit) async {
    //TODO: [Heider Zapa] refactor with new logic
    var seller = storageService.getString('username');
    List<Section> sections =
        await queryLoaderService.getResults('wallet', [seller]);
    emit(state.copyWith(status: WalletStatus.dashboard, sections: sections));
  }
  

  Future<void> _onLoadClients(LoadClients event, Emitter emit) async {
    emit(state.copyWith(status: WalletStatus.loading));

    try {
      var seller = storageService.getString('username');
      var range = event.range;
      List<Section> sections = await queryLoaderService.getResults('wallet-clients', [seller, range]);
      emit(state.copyWith(status: WalletStatus.clients, age: event.range, sections: sections));
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
          event.range!, seller!, event.client!.id.toString());

      emit(state.copyWith(
          status: WalletStatus.invoices,
          client: event.client,
          invoices: invoices));
    } catch (error, stackTrace) {
      emit(
          state.copyWith(status: WalletStatus.failed, error: error.toString()));
    }
  }

  _onSelectInvoices(SelectInvoices event, Emitter emit) {
    //TODO: [Heider Zapa] get invoice from event and emit to state
    emit(state.copyWith(status: WalletStatus.invoices));
  }

  _onCollection(Collection event, Emitter emit) {
    //TODO: [Heider Zapa] get action invoice from event and emit to state
    emit(state.copyWith(status: WalletStatus.collection));
  }
}
