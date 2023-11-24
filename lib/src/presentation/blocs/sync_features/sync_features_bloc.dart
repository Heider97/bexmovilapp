import 'package:bexmovil/src/domain/models/clients.dart';
import 'package:bexmovil/src/domain/repositories/database_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sync_features_event.dart';
part 'sync_features_state.dart';

class SyncFeaturesBloc extends Bloc <SyncFeaturesEvent, SyncFeaturesState>{
  final DatabaseRepository _databaseRepository;

  SyncFeaturesBloc(this._databaseRepository):super(SyncFeaturesInitial());

  Future<void> getData()async{
    await _databaseRepository.getFeatures();
    add(SyncFeatureGet());
  }
}