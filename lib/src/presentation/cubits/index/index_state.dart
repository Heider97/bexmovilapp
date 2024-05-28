part of 'index_cubit.dart';

enum IndexStatus { initial, loading, success, failure }

class IndexState extends Equatable {
  final int? index;
  final PageController? pageController;
  final String? error;
  final IndexStatus? status;

  const IndexState({this.index, this.pageController, this.status, this.error});

  IndexState copyWith(
      {IndexStatus? status,
      int? index,
      PageController? pageController,
      String? error}) {
    return IndexState(
      index: index ?? this.index,
      status: status ?? this.status,
      pageController: pageController ?? this.pageController,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [index, pageController, status, error];
}
