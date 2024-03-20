/* part of 'category_cubit.dart';

abstract class CategoryState extends Equatable {
  final Category? category;
  final String? error;

  const CategoryState({
    this.category,
    this.error
  });

  @override
  List<Object?> get props => [category, error];

}

class CategoryLoading extends CategoryState {
  const CategoryLoading();
}

class CategorySuccess extends CategoryState {
  const CategorySuccess({ super.category });
}

class CategoryFailed extends CategoryState {
  const CategoryFailed({ super.error });
} */