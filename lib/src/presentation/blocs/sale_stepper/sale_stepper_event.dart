part of 'sale_stepper_bloc.dart';

class SaleStepperEvent {}

class ChangeStepEvent extends SaleStepperEvent {
  final int index;
  ChangeStepEvent({required this.index});
}
