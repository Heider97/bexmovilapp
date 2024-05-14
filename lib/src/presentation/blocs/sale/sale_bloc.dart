import 'package:flutter_bloc/flutter_bloc.dart';

//domain
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
    on<LoadClients>(_onLoadClients);
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
    add(LoadClients(state.router!.dayRouter));
  }

  _selectWarehouse(SelectWarehouse event, Emitter emit) {
    print('Selected warehouse ${event.warehouse?.nombodega}');
    emit(state.copyWith(warehouse: event.warehouse));
  }

  _selectPriceList(SelectPriceList event, Emitter emit) {
    print('Selected priceList ${event.listPriceSelected?.nomprecio}');
    emit(state.copyWith(price: event.listPriceSelected));
  }

  _selectRouter(SelectRouter event, Emitter emit) {
    emit(state.copyWith(router: event.router));
  }

  _gridModeChange(GridModeChange event, Emitter emit) {
    emit(state.copyWith(gridView: event.changeMode));
  }

  Future<void> _onLoadRouters(LoadRouters event, Emitter emit) async {
    var seller = storageService.getString('username');

    var routers = <Router>[];

    Map<String, dynamic> variables = await queryLoaderService
        .load('/sales-routers', 'SaleBloc', 'LoadRouters', seller!, []);

    List<String> keys = variables.keys.toList();

    for (var i = 0; i < variables.length; i++) {
      if (keys[i] == 'routers') {
        routers = variables[keys[i]];
      }
    }

    emit(state.copyWith(status: SaleStatus.routers, routers: routers));
  }

  Future<void> _onLoadClients(LoadClients event, Emitter emit) async {
    emit(state.copyWith(status: SaleStatus.loading));

    var clients = <Client>[];
    var seller = storageService.getString('username');

    Map<String, dynamic> variables = await queryLoaderService.load(
        '/sales-clients',
        'SaleBloc',
        'LoadClients',
        seller!,
        [event.codeRouter, seller]);

    List<String> keys = variables.keys.toList();

    for (var i = 0; i < variables.length; i++) {
      if (keys[i] == 'clients') {
        clients = variables[keys[i]];
      }
    }

    emit(state.copyWith(status: SaleStatus.clients, clients: clients));
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

      // emit(state.copyWith(
      //     status: SaleStatus.warehouses,
      //     selectedClient: event.client,
      //     warehouseList: warehouses,
      //     priceList: listPrices));
    }
  }

  Future<void> _onLoadProducts(LoadProducts event, Emitter emit) async {
    emit(state.copyWith(status: SaleStatus.loading));

    var seller = storageService.getString('username');
    var sections = await queryLoaderService.getResults(
        'sales-products', seller!, [event.codprecio, event.codbodega]);
    emit(state.copyWith(
      status: SaleStatus.products,
      // sections: sections,
    ));
  }
}
