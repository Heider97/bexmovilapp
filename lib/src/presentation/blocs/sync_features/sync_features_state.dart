part of 'sync_features_bloc.dart';

abstract class SyncFeaturesState extends Equatable {
  final List<Feature>? features;
  final String? error;

  const SyncFeaturesState({this.features, this.error });

  @override
  List<Object?> get props => [features, error];
}

class SyncFeaturesInitial extends SyncFeaturesState {}

class SyncFeaturesLoading extends SyncFeaturesState {
  const SyncFeaturesLoading({super.features });
}

class SyncFeaturesSuccess extends SyncFeaturesState {
  const SyncFeaturesSuccess({super.features });
}

class SyncFeaturesFailure extends SyncFeaturesState {
  const SyncFeaturesFailure({super.features, super.error });
}
