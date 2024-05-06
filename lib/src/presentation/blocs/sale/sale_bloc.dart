import 'package:bexmovil/src/domain/models/warehouse.dart';
import 'package:bexmovil/src/presentation/blocs/location/location_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//utils
import '../../../domain/models/price.dart';
import '../../../domain/models/section.dart';
import '../../../utils/constants/strings.dart';
//domain
import '../../../domain/models/arguments.dart';
import '../../../domain/models/client.dart';
import '../../../domain/models/router.dart';
import '../../../domain/models/filter.dart';
import '../../../domain/repositories/database_repository.dart';

//services
import '../../../services/storage.dart';
import '../../../services/navigation.dart';
import '../../../services/query_loader.dart';

part 'sale_event.dart';
part 'sale_state.dart';

class SaleBloc extends Bloc<SaleEvent, SaleState> {
  final DatabaseRepository databaseRepository;
  final LocalStorageService storageService;
  final NavigationService navigationService;
  final QueryLoaderService queryLoaderService;

  SaleBloc(this.databaseRepository, this.storageService, this.navigationService,
      this.queryLoaderService)
      : super(const SaleState(status: SaleStatus.initial)) {
    on<LoadRouters>(_onLoadRouters);
    on<LoadClients>(_onLoadClientsRouter);
    on<LoadWarehouses>(_onLoadWarehouses);
    on<SelectWarehouseAndListPrice>(_onSelectWarehouseAndListPrice);
    on<LoadProducts>(_onLoadProducts);
    on<GridModeChange>(_gridModeChange);
    on<SelectRouter>(_selectRouter);
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
    emit(state.copyWith(status: SaleStatus.loading));

    var seller = storageService.getString('username');
    var sections = await queryLoaderService.getResults('sales-warehouses',
        seller!, [event.codbodega, event.codprecio, event.codcliente]);

    emit(state.copyWith(status: SaleStatus.warehouses, sections: sections));
  }

  Future<void> _onSelectWarehouseAndListPrice(
      SelectWarehouseAndListPrice event, Emitter emit) async {
    var seller = storageService.getString('username');
    // var sections =
    //     await queryLoaderService.getResults('sale-warehouses', [seller, ]);
    // var listAvailableWarehouses =
    //     sections!.first.widgets!.first.components!.first.results;
    // print(listAvailableWarehouses);
  }

  Future<void> _onLoadProducts(LoadProducts event, Emitter emit) async {
    emit(state.copyWith(status: SaleStatus.loading));

    var seller = storageService.getString('username');
    var sections = await queryLoaderService.getResults(
        'sales-products', seller!, [event.codprecio, event.codbodega]);
    emit(state.copyWith(status: SaleStatus.products, sections: sections));
  }
}
