import 'package:bexmovil/src/domain/models/feature.dart';
import 'package:bexmovil/src/domain/repositories/database_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sync_features_event.dart';
part 'sync_features_state.dart';

class SyncFeaturesBloc extends Bloc<SyncFeaturesEvent, SyncFeaturesState> {
  final DatabaseRepository _databaseRepository;

  SyncFeaturesBloc(this._databaseRepository) : super(SyncFeaturesInitial()) {
    on<SyncFeatureGet>(_observe);
  }

  void _observe(event, emit) async {
    var features = await _databaseRepository.getFeatures();
    try {
      emit(SyncFeaturesLoading(features: features));

      Future.delayed(const Duration(seconds: 5));

      throw ArgumentError(
          'Parece que algo salió mal realizando la sincronización');
    } catch (e) {
      emit(SyncFeaturesFailure(features: features, error: e.toString()));
    }
  }
}
