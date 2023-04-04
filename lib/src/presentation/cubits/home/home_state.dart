part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  final List<Category>? categories;
  final User? user;
  final String? companyName;
  final String? error;

  const HomeState({
    this.categories,
    this.user,
    this.companyName,
    this.error
  });

  @override
  List<Object?> get props => [categories, user, companyName, error];

}

class HomeLoading extends HomeState {
  const HomeLoading();
}

class HomeSuccess extends HomeState {
  const HomeSuccess({ super.categories, super.user, super.companyName });
}

class HomeFailed extends HomeState {
  const HomeFailed({ super.error });
}