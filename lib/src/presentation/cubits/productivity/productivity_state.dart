part of 'productivity_cubit.dart';

class ProductivityState extends Equatable {

  final String? error;

  const ProductivityState({ this.error });

  @override
  List<Object?> get props => [error];

}

class ProductivityLoading extends ProductivityState {
  const ProductivityLoading();
}

class ProductivitySuccess extends ProductivityState {
  const ProductivitySuccess();
}

class ProductivityFailed extends ProductivityState {
  const ProductivityFailed({super.error});
}
