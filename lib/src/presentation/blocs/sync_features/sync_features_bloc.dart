import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//repositories
import '../../../domain/repositories/database_repository.dart';
//domain
import '../../../domain/models/feature.dart';
//utils
import '../../../utils/constants/strings.dart';
//services
import '../../../locator.dart';
import '../../../services/navigation.dart';

part 'sync_features_event.dart';
part 'sync_features_state.dart';

final NavigationService _navigationService = locator<NavigationService>();

class SyncFeaturesBloc extends Bloc<SyncFeaturesEvent, SyncFeaturesState> {
  final DatabaseRepository _databaseRepository;

  SyncFeaturesBloc(this._databaseRepository) : super(SyncFeaturesInitial()) {
    on<SyncFeatureGet>(_observe);
    on<SyncFeatureLeave>(_go);
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

  void _go(event, emit) async {
    emit(const SyncFeaturesSuccess());
  }

  void goToHome() {
    _navigationService.goTo(Routes.homeRoute);
  }
}
