import 'package:bexmovil/src/domain/models/client.dart';
import 'package:bexmovil/src/domain/models/porduct.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';

import '../../../domain/repositories/database_repository.dart';

part 'sale_event.dart';
part 'sale_state.dart';

class SaleBloc extends Bloc<SaleEvent, SaleState> {
  List<Product> selectedProducts = [];

  final DatabaseRepository databaseRepository;

  SaleBloc(this.databaseRepository) : super(SaleInitial()) {
    on<LoadRouters>(_onLoadRouters);
    on<LoadClients>(_onLoadClients);
    on<SelectClient>(_selectClient);
    on<SelectProducts>(_selectProducts);
    on<ConfirmProducts>(_confirmProducts);
    on<ConfirmOrder>(_confirmOrder);
  }

  Future<void> _onLoadRouters(LoadRouters event, Emitter emit) async {
    var routers = await databaseRepository.findGlobal('tblmruteros', 'codvendedor', '09');
    print(routers.length);

  }

  Future<void> _onLoadClients(LoadClients event, Emitter emit) async {

  }


  _selectClient(SelectClient event, Emitter emit) {
    //TODO Agregar logica de creacion de la orden con el estado = clientSelected y guardado en BD
    if (state is SaleClienteSelected) {
      SaleClienteSelected currentState = state as SaleClienteSelected;
      (event.client != currentState.client)
          ? emit(SaleClienteSelected(client: event.client))
          : emit(SaleInitial());
    } else {
      emit(SaleClienteSelected(client: event.client));
    }
  }

  _selectProducts(SelectProducts event, Emitter emit) {
    //TODO Agregar logica de creacion de la orden con el estado = productsSelection y guardado en BD
    selectedProducts.add(event.product);
    //  emit(SaleProductSelected(listOfProducst: event.products));
  }

  _confirmProducts(ConfirmProducts event, Emitter emit) {
    //TODO Agregar logica de creacion de la orden con el estado = productsConfirmed y guardado en BD
    emit(SaleProductConfirm(listOfProducst: event.products));
  }

  _confirmOrder(ConfirmOrder event, Emitter emit) {
    //TODO Agregar logica de creacion de la orden con el estado = orderConfirmed y guardado en BD
    emit(
        SaleOrderConfirm(listOfProducst: event.products, client: event.client));
  }
}
