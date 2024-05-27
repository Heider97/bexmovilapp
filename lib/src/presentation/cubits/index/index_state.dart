part of 'index_cubit.dart';

enum IndexStatus { initial, loading, success, failure }

extension IndexStatusX on IndexStatus {
  bool get isInitial => this == IndexStatus.initial;
  bool get isLoading => this == IndexStatus.loading;
  bool get isSuccess => this == IndexStatus.success;
  bool get isFailure => this == IndexStatus.failure;
}

abstract class IndexState extends Equatable {
  final int? index;
  final PageController? pageController;
  final String? error;
  final IndexStatus? status;

  const IndexState({this.index, this.pageController, this.status, this.error});

  @override
  List<Object?> get props => [index, pageController, status, error];
}

class IndexInitial extends IndexState {
  const IndexInitial({
    super.status = IndexStatus.initial,
    super.index = 0,
    super.pageController
  });
}

class IndexLoading extends IndexState {
  const IndexLoading({super.status = IndexStatus.loading});
}

class IndexSuccess extends IndexState {
  const IndexSuccess({super.status = IndexStatus.success, super.index});
}

class IndexFailed extends IndexState {
  const IndexFailed(
      {super.status = IndexStatus.failure, super.index, super.error});
}
