import 'package:bexmovil/src/core/abstracts/FormatAbstract.dart';
import 'package:bexmovil/src/domain/models/requests/dynamic_request.dart';
import 'package:bexmovil/src/domain/models/requests/sync_priorities_request.dart';
import 'package:bexmovil/src/utils/resources/data_state.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//repositories
import '../../../domain/repositories/api_repository.dart';
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

class SyncFeaturesBloc extends Bloc<SyncFeaturesEvent, SyncFeaturesState>
    with FormatDate {
  final DatabaseRepository _databaseRepository;
  final ApiRepository _apiRepository;

  SyncFeaturesBloc(this._databaseRepository, this._apiRepository)
      : super(SyncFeaturesInitial()) {
    on<SyncFeatureGet>(_observe);
    on<SyncFeatureLeave>(_go);
  }

  void _observe(event, emit) async {
    var features = await _databaseRepository.getFeatures();
    var configs = await _databaseRepository.getConfigs();

    try {
      emit(SyncFeaturesLoading(features: features));

      var version = configs.firstWhere((element) => element.module == 'login');

      var response = await _apiRepository.priorities(
          request: SyncPrioritiesRequest(date: now(), count: version.value!));

      if (response is DataSuccess) {
        var migrations =
            List<String>.from(response.data!.priorities!.map((e) => e.schema));

        var v = version.value != null ? int.parse(version.value!) : 1;
        await _databaseRepository.init(v, migrations);

        var prioritiesAsync = response.data!.priorities!.where((element) => element.runBackground == 1);

        //TODO: [Heider Zapa] run with isolate



        var prioritiesSync =  response.data!.priorities!.where((element) => element.runBackground == 0);

        Future.forEach(prioritiesSync.toList(), (priority)  async {
          print('getting ${priority.name}');
          final response = await _apiRepository.syncDynamic(request: DynamicRequest(priority.name));
          if(response is DataSuccess) {
            print(response.data!.data);
            // if(response.data!.data != null){
            //   await _databaseRepository.insertAll(priority.name, response.data!.data!);
            // }

          }
        }).then((value) => emit(SyncFeaturesSuccess(features: features)));
      } else {
        emit(SyncFeaturesFailure(features: features, error: response.error));
      }
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
