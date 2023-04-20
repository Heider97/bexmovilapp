part of 'home_cubit.dart';

class HomeState extends Equatable {

  final List<Category>? categories;
  final User? user;
  final String? companyName;
  final String? error;
  final TabController? tabController;
  final List<TabCategory>? tabs;
  final ScrollController? scrollController;

  const HomeState(
      {this.categories,
      this.user,
      this.companyName,
      this.tabController,
      this.tabs,
      this.scrollController,
      this.error});

  @override
  List<Object?> get props => [
        categories,
        user,
        companyName,
        tabController,
        tabs,
        scrollController,
        error
      ];

  HomeState copyWith({
    List<Category>? categories,
    User? user,
    String? companyName,
    String? error,
    TabController? tabController,
    List<TabCategory>? tabs,
    ScrollController? scrollController,
  }) => HomeState(
    categories: this.categories ?? categories,
    user: this.user ?? user,
    companyName: this.companyName ?? companyName,
    tabController: this.tabController ?? tabController,
    tabs: this.tabs ?? tabs,
    scrollController: this.scrollController ?? scrollController
  );
}

class HomeLoading extends HomeState {
  const HomeLoading();
}

class HomeSuccess extends HomeState {
  const HomeSuccess({
    super.categories,
    super.user,
    super.companyName,
    super.tabController,
    super.tabs,
    super.scrollController
  });
}

class HomeFailed extends HomeState {
  const HomeFailed({super.error});
}
