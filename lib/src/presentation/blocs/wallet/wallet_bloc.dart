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
    //TODO: [Heider Zapa] refactor with new logic
    var seller = storageService.getString('username');
    List<Section> sections = await queryLoaderService.getResults('wallet', [seller]);

    for (var section in sections) {
      print('section');
      print(section.toJson());
      if(section.widgets != null) {
        for (var widget in section.widgets!) {
          print('widget');
          print(widget.toJson());
          if(widget.components != null) {
            for (var component in widget.components!) {
              print('component');
              print(component.toJson());
              print(component.results);
            }
          }

        }
      }
    }

    emit(state.copyWith(status: WalletStatus.success, sections: sections));
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
          event.range!, seller!, event.client!.id.toString());

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
