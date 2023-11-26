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

    try {
      var features = await _databaseRepository.getFeatures();

      print('*************');
      print(features);

      emit(SyncFeaturesLoading(features: features));


    } catch (e) {
      emit(SyncFeaturesFailure(error: e.toString()));
    }


  }
}
