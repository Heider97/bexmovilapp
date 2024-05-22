import 'dart:convert';
import 'dart:ffi';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//blocs
import '../../blocs/processing_queue/processing_queue_bloc.dart';

//repositories

import '../../../domain/models/processing_queue.dart';
import '../../../domain/repositories/api_repository.dart';
import '../../../domain/repositories/database_repository.dart';
//domain
import '../../../domain/models/isolate.dart';
import '../../../domain/models/feature.dart';

import '../../../domain/models/requests/dynamic_request.dart';
import '../../../domain/models/requests/sync_priorities_request.dart';
import '../../../domain/models/responses/dynamic_response.dart';
//abstracts
import '../../../domain/abstracts/format_abstract.dart';
//utils
import '../../../utils/constants/strings.dart';
import '../../../utils/resources/data_state.dart';
//services
import '../../../services/navigation.dart';
import '../../../services/storage.dart';

part 'sync_features_event.dart';
part 'sync_features_state.dart';

class SyncFeaturesBloc extends Bloc<SyncFeaturesEvent, SyncFeaturesState>
    with FormatDate {
  final DatabaseRepository databaseRepository;
  final ApiRepository apiRepository;
  final ProcessingQueueBloc processingQueueBloc;
  final NavigationService navigationService;
  final LocalStorageService storageService;

  SyncFeaturesBloc(this.databaseRepository, this.apiRepository,
      this.processingQueueBloc, this.navigationService, this.storageService)
      : super(SyncFeaturesInitial()) {
    on<SyncFeatureGet>(_observe);
    on<SyncFeatureLeave>(_go);
  }

  Future<void> heavyTask(IsolateModel model) async {
    for (var i = 0; i < model.iteration; i++) {
      if (model.arguments![i].isNotEmpty) {
        await model.functions[i](
            model.arguments![i]['table_name'], model.arguments![i]['content']);
      } else {
        await model.functions[i]();
      }
    }
  }

  Future<void> insertDynamicData(String tableName, String content) async {
    var processingQueue = ProcessingQueue(
        body: jsonEncode({
          'table_name': tableName,
          'content': content,
        }),
        task: 'incomplete',
        code: 'store_dynamic_data',
        createdAt: now(),
        updatedAt: now());
    processingQueueBloc.addProcessingQueue(processingQueue);
  }

  void _observe(event, emit) async {
    var features = await databaseRepository.getAllFeatures();
    var configs = await databaseRepository.getConfigs('login');

    try {
      emit(SyncFeaturesLoading(features: features));

      final startTime = DateTime.now();
      var version = configs.firstWhere((element) => element.name == 'version');

      var response = await apiRepository.priorities(
          request: SyncPrioritiesRequest(
              date: now(), version: version.value ?? "0"));

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
        await databaseRepository.runMigrations(migrations);

        var prioritiesAsync = response.data!.priorities!
            .where((element) => element.runBackground == 1);

        //TODO: [Heider Zapa] run with isolate
        var prioritiesSync = response.data!.priorities!
            .where((element) => element.runBackground == 0);

        var functions = <Function>[];
        var arguments = <Map<String, dynamic>>[];

        for (var priority in prioritiesAsync) {
          functions.add(insertDynamicData);
          arguments.add(
              {'table_name': priority.name, 'content': 'application/json'});
        }

        var isolateModel =
            IsolateModel(functions, arguments, prioritiesAsync.length);
        await heavyTask(isolateModel);

        List<String> tables = [];

        List<Future<DataState<DynamicMultitableResponse>>> futures = [];

        //MONTAR LA DIVISION,

        for (var priority in prioritiesSync) {
          tables.add(priority.name);
        }

        emit(SyncFeaturesLoading(features: features, processes: futures.length));

        List<DataState<DynamicResponse>> responses = await Future.wait(futures);

        List<Future<dynamic>> futureInserts = [];

        var i = 0;
        for (var response in responses) {
          if (response is DataSuccess) {
            if (response.data != null && response.data!.data != null) {
              /*     futureInserts.add(databaseRepository.insertAll(
                  tables[i], response.data!.data!)); */

              var keys = response.data!.data!.keys.toList();

              for (var key in keys) {
                futureInserts.add(databaseRepository.insertAll(
                    key, response.data!.data![key]));
              }
              print(response.data);
              print('Cantidad de peticione: $i');
            }
          }
          i++;
          emit(SyncFeaturesLoading(features: features, processes: futures.length, completed: i));
        }

        await Future.wait(futureInserts).whenComplete(() {
          final endTime = DateTime.now();
          final elapsedTime = endTime.difference(startTime);
          print(
              'Time taken for sequential calls: ${elapsedTime.inMilliseconds} ms');

          emit(SyncFeaturesSuccess(features: features));
        });
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
    navigationService.goTo(AppRoutes.home);
  }
}

List<List<String>> subdividirArreglo(List<String> arreglo, int maxElementos) {
  List<List<String>> subarreglos = [];

  for (int i = 0; i < arreglo.length; i += maxElementos) {
    int fin =
        (i + maxElementos < arreglo.length) ? i + maxElementos : arreglo.length;
    subarreglos.add(arreglo.sublist(i, fin));
  }

  return subarreglos;
}
