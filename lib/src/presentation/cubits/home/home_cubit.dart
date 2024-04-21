import 'package:bexmovil/src/domain/models/requests/client_location_request.dart';
import 'package:equatable/equatable.dart';
import 'package:collection/collection.dart';

//cubit

import '../../../domain/abstracts/format_abstract.dart';
import '../../../domain/models/requests/dynamic_request.dart';
import '../../../domain/models/requests/sync_priorities_request.dart';
import '../../../domain/models/responses/dynamic_response.dart';
import '../base/base_cubit.dart';

//utils
import '../../../utils/constants/strings.dart';
import '../../../utils/resources/data_state.dart';

//domain
import '../../../domain/models/user.dart';
import '../../../domain/models/section.dart';
import '../../../domain/models/application.dart';
import '../../../domain/models/feature.dart';
import '../../../domain/models/kpi.dart';
import '../../../domain/models/isolate.dart';
//requests
import '../../../domain/models/requests/module_request.dart';
import '../../../domain/models/requests/filter_request.dart';
import '../../../domain/repositories/database_repository.dart';
import '../../../domain/repositories/api_repository.dart';

//service
import '../../../services/storage.dart';
import '../../../services/navigation.dart';
import '../../../services/query_loader.dart';

part 'home_state.dart';

class HomeCubit extends BaseCubit<HomeState> with FormatDate {
  final DatabaseRepository databaseRepository;
  final ApiRepository apiRepository;
  final LocalStorageService storageService;
  final NavigationService navigationService;
  final QueryLoaderService queryLoaderService;

  HomeCubit(this.databaseRepository, this.apiRepository, this.storageService,
      this.navigationService, this.queryLoaderService)
      : super(const HomeLoading());

  Future<void> heavyTask(IsolateModel model) async {
    for (var i = 0; i < model.iteration; i++) {
      await model.functions[i]();
    }
  }

  Future<void> getConfigs() async {
    final response = await apiRepository.configs();

    if (response is DataSuccess) {
      await databaseRepository.init();
      await databaseRepository.insertConfigs(response.data!.configs);
    } else {
      emit(HomeFailed(
        error: 'configs-${response.data!.message}',
      ));
    }
  }

  Future<void> getFilters() async {
    final response = await apiRepository.filters(
        request:
            FilterRequest(codvendedor: storageService.getString('username')!));
    if (response is DataSuccess && response.data != null) {
      await databaseRepository.insertFilters(response.data!.filters!);
      if (response.data!.filters != null) {
        for (var filter in response.data!.filters!) {
          await databaseRepository.insertOptions(filter.options!);
        }
      }
    } else {
      emit(HomeFailed(error: 'graphics-${response.data!.message}'));
    }
  }

  Future<void> init() async {
    if (isBusy) return;

    await run(() async {
      emit(const HomeLoading());

      final user = User.fromMap(storageService.getObject('user')!);
      final seller = storageService.getString('username');
      final sections = await queryLoaderService.getResults('home', [seller]);
      
      emit(HomeSuccess(
          user: user,
          sections: sections,
        ));
    });
  }

  Future<void> sync() async {
    if (isBusy) return;

    await run(() async {
      emit(const HomeSynchronizing());

      var functions = [
        getConfigs,
        getFilters
      ];

      var isolateModel = IsolateModel(functions, null, 2);
      await heavyTask(isolateModel);

      await databaseRepository.emptyAllTables();

      var configs = await databaseRepository.getConfigs('login');

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

        // var functions = <Function>[];
        // var arguments = <Map<String, dynamic>>[];
        //
        // for (var priority in prioritiesAsync) {
        //   print(priority.toJson());
        //   functions.add(insertDynamicData);
        //   arguments.add(
        //       {'table_name': priority.name, 'content': 'application/json'});
        // }

        // var isolateModel =
        //     IsolateModel(functions, arguments, prioritiesAsync.length);
        // await heavyTask(isolateModel);

        List<String> tables = [];

        List<Future<DataState<DynamicResponse>>> futures = [];

        for (var priority in prioritiesSync) {
          futures.add(apiRepository.syncDynamic(
              request: DynamicRequest(priority.name, 'application/json')));
          tables.add(priority.name);
        }

        List<DataState<DynamicResponse>> responses = await Future.wait(futures);

        List<Future<dynamic>> futureInserts = [];

        var i = 0;
        for (var response in responses) {
          if (response is DataSuccess) {
            if (response.data != null && response.data!.data != null) {
              futureInserts.add(databaseRepository.insertAll(
                  tables[i], response.data!.data!));
            }
          }
          i++;
        }

        final user = User.fromMap(storageService.getObject('user')!);
        final seller = storageService.getString('username');
        final sections = await queryLoaderService.getResults('home', [seller]);

        await Future.wait(futureInserts)
            .whenComplete(() => emit(HomeSuccess(
          user: user,
          sections: sections,
        )));
      } else {

        // emit(SyncFeaturesFailure(features: features, error: response.error));
      }
    });
  }

  Future<void> logout() async {
    await Future.wait([
      //DELETE  DATABASE INFORMATION
    ]);

    storageService.remove('token');
    navigationService.replaceTo(AppRoutes.login);
  }
}
