import 'package:bexmovil/src/domain/models/client.dart';
import 'package:bexmovil/src/domain/models/porduct.dart';
import 'package:bexmovil/src/domain/models/router.dart';
import 'package:bexmovil/src/services/storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repositories/database_repository.dart';

part 'sale_event.dart';
part 'sale_state.dart';

class SaleBloc extends Bloc<SaleEvent, SaleState> {
  List<Product> selectedProducts = [];

  final DatabaseRepository databaseRepository;
  final LocalStorageService storageService;

  SaleBloc(this.databaseRepository, this.storageService) : super(SaleInitial([], [])) {
    on<LoadRouters>(_onLoadRouters);
    //on<LoadRouters>(_onLoadClientsRouter);
    on<LoadClients>(_onLoadClientsRouter);
    on<SelectClient>(_selectClient);
    on<SelectProducts>(_selectProducts);
    on<ConfirmProducts>(_confirmProducts);
    on<ConfirmOrder>(_confirmOrder);
  }

  Future<void> _onLoadRouters(LoadRouters event, Emitter emit) async {
    var sellerCode = storageService.getString('username');
    var routers = await databaseRepository.getAllRoutersGroupByClient(sellerCode!);
    emit(SaleInitial(routers, []));

  }

  Future<void> _onLoadClientsRouter(LoadClients event, Emitter emit) async {
    var sellerCode = storageService.getString('username');
    var clientsRouters = await databaseRepository.getAllClientsRouter(sellerCode!, '0901');
    emit(SaleInitial([], clientsRouters));
  }



  _selectClient(SelectClient event, Emitter emit) {
    //TODO Agregar logica de creacion de la orden con el estado = clientSelected y guardado en BD
    if (state is SaleClienteSelected) {
      SaleClienteSelected currentState = state as SaleClienteSelected;
      (event.client != currentState.client)
          ? emit(SaleClienteSelected(state.routers,state.clients, client: event.client))
          : emit(SaleInitial(state.routers, state.clients));
    } else {
      emit(SaleClienteSelected(state.routers, state.clients, client: event.client));
    }
  }

  _selectProducts(SelectProducts event, Emitter emit) {
    //TODO Agregar logica de creacion de la orden con el estado = productsSelection y guardado en BD
    selectedProducts.add(event.product);
    //  emit(SaleProductSelected(listOfProducst: event.products));
  }

  _confirmProducts(ConfirmProducts event, Emitter emit) {
    //TODO Agregar logica de creacion de la orden con el estado = productsConfirmed y guardado en BD
    emit(SaleProductConfirm(state.routers,state.clients, listOfProducst: event.products));
  }

  _confirmOrder(ConfirmOrder event, Emitter emit) {
    //TODO Agregar logica de creacion de la orden con el estado = orderConfirmed y guardado en BD
    emit(
        SaleOrderConfirm(state.routers, state.clients,listOfProducst: event.products, client: event.client));
  }
}
