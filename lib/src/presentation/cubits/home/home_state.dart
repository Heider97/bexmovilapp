
part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  final User? user;
  final List<Feature>? features;
  final List<Kpi>? kpis;
  final String? error;

  const HomeState({this.user, this.features, this.kpis, this.error});

  @override
  List<Object?> get props => [user, kpis, error];
}

class HomeLoading extends HomeState {
  const HomeLoading();
}

class HomeSuccess extends HomeState {
  const HomeSuccess({super.user, super.features, super.kpis});
}

class HomeFailed extends HomeState {
  const HomeFailed({super.error});
}

