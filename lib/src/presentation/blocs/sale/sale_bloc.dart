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

  SaleBloc(this.databaseRepository, this.storageService) : super(SaleInitial([])) {
    on<LoadRouters>(_onLoadRouters);
    on<LoadClients>(_onLoadClients);
    on<SelectClient>(_selectClient);
    on<SelectProducts>(_selectProducts);
    on<ConfirmProducts>(_confirmProducts);
    on<ConfirmOrder>(_confirmOrder);
  }

  Future<void> _onLoadRouters(LoadRouters event, Emitter emit) async {
    var codvendedor = storageService.getString('username');
    var routers = await databaseRepository.getAllRoutersGroupByClient(codvendedor!);
    emit(SaleInitial(routers));

  }

  Future<void> _onLoadClients(LoadClients event, Emitter emit) async {

  }


  _selectClient(SelectClient event, Emitter emit) {
    //TODO Agregar logica de creacion de la orden con el estado = clientSelected y guardado en BD
    if (state is SaleClienteSelected) {
      SaleClienteSelected currentState = state as SaleClienteSelected;
      (event.client != currentState.client)
          ? emit(SaleClienteSelected(state.routers, client: event.client))
          : emit(SaleInitial(state.routers));
    } else {
      emit(SaleClienteSelected(state.routers, client: event.client));
    }
  }

  _selectProducts(SelectProducts event, Emitter emit) {
    //TODO Agregar logica de creacion de la orden con el estado = productsSelection y guardado en BD
    selectedProducts.add(event.product);
    //  emit(SaleProductSelected(listOfProducst: event.products));
  }

  _confirmProducts(ConfirmProducts event, Emitter emit) {
    //TODO Agregar logica de creacion de la orden con el estado = productsConfirmed y guardado en BD
    emit(SaleProductConfirm(state.routers, listOfProducst: event.products));
  }

  _confirmOrder(ConfirmOrder event, Emitter emit) {
    //TODO Agregar logica de creacion de la orden con el estado = orderConfirmed y guardado en BD
    emit(
        SaleOrderConfirm(state.routers, listOfProducst: event.products, client: event.client));
  }
}
