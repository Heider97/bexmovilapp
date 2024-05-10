import 'package:flutter_bloc/flutter_bloc.dart';
//utils

import '../../../utils/constants/strings.dart';
//domain
import '../../../domain/models/arguments.dart';
import '../../../domain/models/client.dart';
import '../../../domain/models/router.dart';
import '../../../domain/models/filter.dart';
import '../../../domain/models/price.dart';
import '../../../domain/models/section.dart';
import '../../../domain/models/navigation.dart';
import '../../../domain/models/warehouse.dart';
import '../../../domain/models/product.dart';
import '../../../domain/repositories/database_repository.dart';

//services
import '../../../services/storage.dart';
import '../../../services/navigation.dart';
import '../../../services/query_loader.dart';
import '../../../services/styled_dialog_controller.dart';

part 'sale_event.dart';
part 'sale_state.dart';

class SaleBloc extends Bloc<SaleEvent, SaleState> {
  final DatabaseRepository databaseRepository;
  final LocalStorageService storageService;
  final NavigationService navigationService;
  final QueryLoaderService queryLoaderService;
  final StyledDialogController styledDialogController;

  SaleBloc(this.databaseRepository, this.storageService, this.navigationService,
      this.queryLoaderService, this.styledDialogController)
      : super(const SaleState(status: SaleStatus.initial)) {
    on<LoadRouters>(_onLoadRouters);
    on<LoadClients>(_onLoadClientsRouter);
    on<LoadProducts>(_onLoadProducts);
    on<LoadWarehouses>(_onLoadWarehouses);

    on<SelectWarehouse>(_selectWarehouse);
    on<SelectPriceList>(_selectPriceList);

    on<GridModeChange>(_gridModeChange);
    on<SelectRouter>(_selectRouter);

    on<ResetStatus>(_resetStatus);
  }

  _resetStatus(ResetStatus event, Emitter emit) {
    emit(state.copyWith(status: event.status));
    add(LoadClients(state.selectedRouter!.dayRouter));
  }

  _selectWarehouse(SelectWarehouse event, Emitter emit) {
    print('Selected warehouse ${event.warehouse?.nombodega}');
    emit(state.copyWith(selectedWarehouse: event.warehouse));
  }

  _selectPriceList(SelectPriceList event, Emitter emit) {
    print('Selected priceList ${event.listPriceSelected?.nomprecio}');
    emit(state.copyWith(selectedPrice: event.listPriceSelected));
  }

  _selectRouter(SelectRouter event, Emitter emit) {
    emit(state.copyWith(selectedRouter: event.router));
  }

  _gridModeChange(GridModeChange event, Emitter emit) {
    emit(state.copyWith(gridView: event.changeMode));
  }

  Future<void> _onLoadRouters(LoadRouters event, Emitter emit) async {
    var seller = storageService.getString('username');
    var sections =
        await queryLoaderService.getResults('sales', seller!, [seller]);

    emit(state.copyWith(status: SaleStatus.routers, sections: sections));
  }

  Future<void> _onLoadClientsRouter(LoadClients event, Emitter emit) async {
    var clients = <Client>[];
    emit(state.copyWith(status: SaleStatus.loading));

    var seller = storageService.getString('username');
    var sections = await queryLoaderService
        .getResults('sales-clients', seller!, [event.codeRouter, seller]);

    clients = sections!.first.widgets!.first.components!.first.results;

    if (event.codeRouter != null) {
      var filters = await databaseRepository.getAllFilters();

      Future.forEach(filters, (filter) async {
        filter.options =
            await databaseRepository.getAllOptionsByFilter(filter.id!);
      });

      emit(state.copyWith(
          status: SaleStatus.clients, clients: clients, sections: sections));
    } else {
      emit(state.copyWith(status: SaleStatus.clients, clients: clients));
    }
  }

  buscarClientes(String valor) {
    if (valor == '') {
      return state.clients!;
    }

    return state.clients!.where((client) {
      return client.name!.toLowerCase().contains(valor) ||
          client.businessName!.toLowerCase().contains(valor);
    }).toList();
  }

  Future<void> _onLoadWarehouses(LoadWarehouses event, Emitter emit) async {
    var seller = storageService.getString('username');
    var sections = await queryLoaderService.getResults('sales-warehouses',
        seller!, [event.codbodega, event.codprecio, event.codcliente]);

    if (sections.first.widgets!.first.components!.first.results is Navigation &&
        event.navigation == 'go') {
      var navigation = sections.first.widgets!.first.components!.first.results;
      await navigationService.goTo(navigation.route!,
          arguments: navigation.argument);
    } else if (sections.first.widgets!.first.components!.first.results
            is Navigation &&
        event.navigation == 'back') {
      add(LoadClients(event.codrouter));
      styledDialogController.closeVisibleDialog();
    } else {
      List<Warehouse>? warehouses =
          sections.first.widgets!.first.components!.first.results;
      List<Price>? listPrices =
          sections[1].widgets!.first.components!.first.results;

      emit(state.copyWith(
          status: SaleStatus.warehouses,
          selectedClient: event.client,
          warehouseList: warehouses,
          priceList: listPrices));
    }
  }

  Future<void> _onLoadProducts(LoadProducts event, Emitter emit) async {
    emit(state.copyWith(status: SaleStatus.loading));

    var seller = storageService.getString('username');
    var sections = await queryLoaderService.getResults(
        'sales-products', seller!, [event.codprecio, event.codbodega]);
    emit(state.copyWith(
      status: SaleStatus.products,
      sections: sections,
    ));
  }
}
