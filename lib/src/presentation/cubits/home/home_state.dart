part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  final List<Category>? categories;
  final String? error;

  const HomeState({
    this.categories,
    this.error
  });

  @override
  List<Object?> get props => [categories, error];

}

class HomeLoading extends HomeState {
  const HomeLoading();
}

class HomeSuccess extends HomeState {
  const HomeSuccess({ super.categories });
}

class HomeFailed extends HomeState {
  const HomeFailed({ super.error });
}