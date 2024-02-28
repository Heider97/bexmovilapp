part of 'home_cubit.dart';

class HomeState extends Equatable {
  final User? user;
  final List<Feature>? features;
  final List<Kpi>? kpisOneLine;
  final List<List<Kpi>>? kpisSlidableOneLine;
  final List<Kpi>? kpisSecondLine;
  final List<List<Kpi>>? kpisSlidableSecondLine;
  final List<Application>? applications;
  final String? error;

  const HomeState(
      {this.user,
      this.features,
      this.kpisOneLine,
      this.kpisSlidableOneLine,
      this.kpisSecondLine,
      this.kpisSlidableSecondLine,
      this.applications,
      this.error});

  HomeState copyWith(
      {User? user,
      List<Feature>? features,
      List<Kpi>? kpisOneLine,
      List<List<Kpi>>? kpisSlidableOneLine,
      List<Kpi>? kpisSecondLine,
      List<List<Kpi>>? kpisSlidableSecondLine,
      List<Application>? applications,
      String? error}) {
    return HomeState(
      user: user ?? this.user,
      features: features ?? this.features,
      kpisOneLine: kpisOneLine ?? this.kpisOneLine,
      kpisSlidableOneLine: kpisSlidableOneLine ?? this.kpisSlidableOneLine,
      kpisSecondLine: kpisSecondLine ?? this.kpisSecondLine,
      kpisSlidableSecondLine:
          kpisSlidableSecondLine ?? this.kpisSlidableSecondLine,
      applications: applications ?? this.applications,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props =>
      [user, features, kpisOneLine, kpisSecondLine, applications, error];
}

class HomeLoading extends HomeState {
  const HomeLoading();
}

class HomeSuccess extends HomeState {
  const HomeSuccess(
      {super.user,
      super.features,
      super.kpisOneLine,
      super.kpisSlidableOneLine,
      super.kpisSecondLine,
      super.kpisSlidableSecondLine,
      super.applications});
}

class HomeFailed extends HomeState {
  const HomeFailed({super.error});
}
