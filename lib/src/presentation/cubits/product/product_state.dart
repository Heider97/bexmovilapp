part of 'product_cubit.dart';

abstract class ProductState extends Equatable {
  final Product? product;
  final String? error;

  const ProductState({
    this.product,
    this.error
  });

  @override
  List<Object?> get props => [product, error];

}

class ProductLoading extends ProductState {
  const ProductLoading();
}

class ProductSuccess extends ProductState {
  const ProductSuccess({ super.product });
}

class ProductFailed extends ProductState {
  const ProductFailed({ super.error });
}