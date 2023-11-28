import 'package:bexmovil/src/core/abstracts/FormatAbstract.dart';
import 'package:bexmovil/src/domain/models/requests/dynamic_request.dart';
import 'package:bexmovil/src/domain/models/requests/sync_priorities_request.dart';
import 'package:bexmovil/src/domain/models/responses/dynamic_response.dart';
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
          request:
              SyncPrioritiesRequest(date: now(), count: version.value ?? "0"));

      if (response is DataSuccess) {
        var migrations = <String>[];
        for (var migration in response.data!.priorities!) {
          try {
            if (migration.schema != null) {
              String sqlScriptWithoutEscapes = migration.schema!
                  .replaceAll(RegExp(r'\\r\\n|\r\n|\n|\r'), ' ');
              List<String> scriptsSeparated =
                  sqlScriptWithoutEscapes.split('CREATE');
              for (String createTableScript in scriptsSeparated) {
                try {
                  String scriptCompleted =
                      'CREATE $createTableScript'.replaceAll(';', '');
                  migrations.add(scriptCompleted);
                } catch (ex) {
                  print('Error al ejecutar el script:\n$ex');
                }
              }
            }
          } catch (ex) {
            print('Error $ex');
          }
        }
        migrations.removeWhere((element) => element == 'CREATE ');
        await _databaseRepository.runMigrations(migrations);
        var prioritiesAsync = response.data!.priorities!
            .where((element) => element.runBackground == 1);
        print(prioritiesAsync.length);
        //TODO: [Heider Zapa] run with isolate
        var prioritiesSync = response.data!.priorities!
            .where((element) => element.runBackground == 0);
        List<String> tables = [];
        List<Future<DataState<DynamicResponse>>> futures = [];
        for (var priority in prioritiesSync) {
          futures.add(_apiRepository.syncDynamic(
              request: DynamicRequest(priority.name)));
          tables.add(priority.name);
        }
        List<DataState<DynamicResponse>> responses = await Future.wait(futures);

        List<Future<dynamic>> futureInserts = [];

        var i = 0;
        for (var response in responses) {
          if (response is DataSuccess) {
            //TODO: [Heider Zapa] capture api with error and should be request when retry
            if (response.data!.data != null) {
              futureInserts.add(_databaseRepository.insertAll(
                  tables[i], response.data!.data!));
            }
          }
        }

        await Future.wait(futureInserts);

        emit(SyncFeaturesSuccess(features: features));
      } else {
        emit(SyncFeaturesFailure(features: features, error: response.error));
      }
    } catch (e) {
      print(e.toString());
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
