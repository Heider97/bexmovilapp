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
  }

  Future<void> _onLoadGraphics(LoadGraphics event, Emitter emit) async {
    var seller = storageService.getString('username');
    var graphics = [];

    Map<String, dynamic> variables = await queryLoaderService
        .load('/wallet-dashboard', 'WalletBloc', 'LoadGraphics', seller!, []);

    List<String> keys = variables.keys.toList();

    for (var i = 0; i < variables.length; i++) {
      if (keys[i] == 'graphics') {
        graphics = variables[keys[i]];
      }
    }

    emit(state.copyWith(status: WalletStatus.dashboard, graphics: graphics));
  }

  Future<void> _onLoadClients(LoadClients event, Emitter emit) async {
    emit(state.copyWith(status: WalletStatus.loading));

    try {
      var seller = storageService.getString('username');
      var range = event.range;
      List<Section> sections = await queryLoaderService
          .getResults('wallet-clients', seller!, [seller, range]);
      emit(state.copyWith(
          status: WalletStatus.clients, age: event.range, sections: sections));
    } catch (error, stackTrace) {
      emit(
          state.copyWith(status: WalletStatus.failed, error: error.toString()));
    }
  }

  Future<void> _onLoadSummaries(LoadSummaries event, Emitter emit) async {
    emit(state.copyWith(status: WalletStatus.loading));

    try {
      var seller = storageService.getString('username');
      var client = event.client!.id.toString();
      var range = event.range;
      List<Section> sections = await queryLoaderService
          .getResults('wallet-summaries', seller!, [seller, client, range]);
      emit(state.copyWith(
          status: WalletStatus.invoices, age: event.range, sections: sections));
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
