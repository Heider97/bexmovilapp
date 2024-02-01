import 'package:bexmovil/src/domain/models/client.dart';
import 'package:bexmovil/src/domain/models/porduct.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sale_event.dart';
part 'sale_state.dart';

class SaleBloc extends Bloc<SaleEvent, SaleState> {
  List<Product> selectedProducts = [];

  SaleBloc() : super(SaleInitial()) {
    on<SelectClient>(_selectClient);
    on<SelectProducts>(_selectProducts);
    on<ConfirmProducts>(_confirmProducts);
    on<ConfirmOrder>(_confirmOrder);
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
