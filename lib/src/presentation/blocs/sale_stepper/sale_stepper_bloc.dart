import 'package:bloc/bloc.dart';

part 'sale_stepper_event.dart';
part 'sale_stepper_state.dart';

class SaleStepperBloc extends Bloc<SaleStepperEvent, SalesStepperState> {
  SaleStepperBloc() : super(SalesStepperInitial()) {
    on<ChangeStepEvent>(_changeStepEvent);
  }

  _changeStepEvent(ChangeStepEvent event, Emitter emit) {
    switch (event.index) {
      case 0:
        emit(SalesStepperClientSelection());

        break;
      case 1:
        emit(SalesStepperProductsSelection());
        break;
      case 2:
        emit(SalesStepperOrderDetails());
        break;
      default:
        break;
    }
  }
}
