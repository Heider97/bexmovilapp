import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//utils
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
    on<NavigationSale>(_onNavigation);
    // on<SelectClient>(_selectClient);
    // on<ConfirmProducts>(_confirmProducts);
    // on<ConfirmOrder>(_confirmOrder);
  }

  Future<void> _onLoadRouters(LoadRouters event, Emitter emit) async {
    var sellerCode = storageService.getString('username');
    var results = await queryLoaderService.getResults(
        List<Router>, 'sales', []);
    var routers = (results)?.map((e) => e as Router).toList();
    emit(state.copyWith(status: SaleStatus.success, routers: routers));
  }

  Future<void> _onLoadClientsRouter(LoadClients event, Emitter emit) async {
    emit(state.copyWith(status: SaleStatus.loading));

    var sellerCode = storageService.getString('username');
    var clients = <Client>[];

    if (event.codeRouter != null) {
      clients = await databaseRepository.getAllClientsRouter(
          sellerCode!, event.codeRouter!);

      var filters = await databaseRepository.getAllFilters();

      Future.forEach(filters, (filter) async {
        filter.options =
            await databaseRepository.getAllOptionsByFilter(filter.id!);
      });

      emit(state.copyWith(
          status: SaleStatus.success, clients: clients, filters: filters));
    } else {
      emit(state.copyWith(status: SaleStatus.success, clients: []));
    }
  }

  Future<void> _onNavigation(NavigationSale event, Emitter emit) async {
    final arguments =
        NavigationArgument(clients: event.clients, nearest: event.nearest);
    navigationService.goTo(AppRoutes.navigation, arguments: arguments);
    emit(state.copyWith());
  }

  // _selectClient(SelectClient event, Emitter emit) {
  //   //TODO Agregar logica de creacion de la orden con el estado = clientSelected y guardado en BD
  //   if (state is SaleClienteSelected) {
  //     SaleClienteSelected currentState = state as SaleClienteSelected;
  //     (event.client != currentState.client)
  //         ? emit(SaleClienteSelected(state.routers, state.clients,
  //             client: event.client))
  //         : emit(SaleInitial(state.routers, state.clients));
  //   } else {
  //     emit(SaleClienteSelected(state.routers, state.clients,
  //         client: event.client));
  //   }
  // }

  // _confirmProducts(ConfirmProducts event, Emitter emit) {
  //   //TODO Agregar logica de creacion de la orden con el estado = productsConfirmed y guardado en BD
  //   emit(SaleProductConfirm(state.routers,state.clients, listOfProducst: event.products));
  // }
  //
  // _confirmOrder(ConfirmOrder event, Emitter emit) {
  //   //TODO Agregar logica de creacion de la orden con el estado = orderConfirmed y guardado en BD
  //   emit(
  //       SaleOrderConfirm(state.routers, state.clients,listOfProducst: event.products, client: event.client));
  // }
}
