part of 'cart_cubit.dart';

abstract class CartState extends Equatable {
  final List? products;
  final String? error;

  const CartState({
    this.products,
    this.error
  });

  @override
  List<Object?> get props => [products, error];

}

class CartLoading extends CartState {
  const CartLoading();
}

class CartSuccess extends CartState {
  const CartSuccess({ super.products });
}

class CartFailed extends CartState {
  const CartFailed({ super.error });
}