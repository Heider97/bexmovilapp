part of 'home_cubit.dart';

class HomeState extends Equatable {
  final User? user;
  final List<Section>? sections;
  final String? error;

  const HomeState(
      {this.user,
      this.sections,
      this.error});

  HomeState copyWith(
      {User? user,
      List<Section>? sections,
      String? error}) {
    return HomeState(
      user: user ?? this.user,
      sections: sections ?? this.sections,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props =>
      [user, sections, error];
}

class HomeLoading extends HomeState {
  const HomeLoading();
}

class HomeSynchronizing extends HomeState {
  const HomeSynchronizing();
}

class HomeSuccess extends HomeState {
  const HomeSuccess(
      {super.user,
      super.sections,
  });
}

class HomeFailed extends HomeState {
  const HomeFailed({super.error});
}
