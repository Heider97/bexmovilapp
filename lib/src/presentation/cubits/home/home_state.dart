part of 'home_cubit.dart';

enum HomeStatus {
  loading,
  synchronizing,
  success,
  failed
}

class HomeState extends Equatable {
  final User? user;
  final HomeStatus? status;

  final List<Feature>? features;
  final List<Kpi>? kpis;
  final List<Application>? applications;

  final String? error;

  const HomeState(
      {this.user,
      this.status,
      this.features,
      this.kpis,
      this.applications,
      this.error});

  HomeState copyWith(
      {User? user,
      HomeStatus? status,
      List<Feature>? features,
      List<Kpi>? kpis,
      List<Application>? applications,
      String? error}) {
    return HomeState(
      user: user ?? this.user,
      features: features ?? this.features,
      kpis: kpis ?? this.kpis,
      applications: applications ?? this.applications,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [user, status, error];
}
