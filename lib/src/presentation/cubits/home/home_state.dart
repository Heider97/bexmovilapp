part of 'home_cubit.dart';

class HomeState extends Equatable {
  final User? user;
  final List<Feature>? features;
  final List<Kpi>? kpisOneLine;
  final List<Kpi>? kpisSecondLine;
  final List<Application>? applications;
  final String? error;

  const HomeState(
      {this.user,
      this.features,
      this.kpisOneLine,
      this.kpisSecondLine,
      this.applications,
      this.error});

  HomeState copyWith(
      {User? user,
      List<Feature>? features,
      List<Kpi>? kpisOneLine,
      List<Kpi>? kpisSecondLine,
      List<Application>? applications,
      String? error}) {
    return HomeState(
      user: user ?? this.user,
      features: features ?? this.features,
      kpisOneLine: kpisOneLine ?? this.kpisOneLine,
      kpisSecondLine: kpisSecondLine ?? this.kpisSecondLine,
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
      super.kpisSecondLine,
      super.applications});
}

class HomeFailed extends HomeState {
  const HomeFailed({super.error});
}
