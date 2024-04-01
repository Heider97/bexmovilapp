import 'package:bexmovil/src/domain/models/requests/client_location_request.dart';
import 'package:equatable/equatable.dart';
import 'package:collection/collection.dart';

//cubit

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

class HomeCubit extends BaseCubit<HomeState> {
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

  Future<void> getModules() async {
    //TODO: [Heider Zapa] refacto with new logic
    // final response = await apiRepository.modules(
    //     request:
    //         ModuleRequest(codvendedor: storageService.getString('username')!));
    //
    // if (response is DataSuccess) {
    //   await databaseRepository.init();
    //   if (response.data != null && response.data!.modules != null) {
    //     var modules = response.data!.modules;
    //     await databaseRepository.insertModules(modules!);
    //     for (var module in modules) {
    //       if (module.components != null) {
    //         await databaseRepository.insertComponents(module.components!);
    //         for (var component in module.components!) {
    //           await databaseRepository.insertQueries(component.queries!);
    //         }
    //       }
    //     }
    //   }
    // } else {
    //   emit(HomeFailed(
    //     error: 'modules-${response.data!.message}',
    //   ));
    // }
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
        getModules,
        getConfigs,
        getFilters
      ];

      var isolateModel = IsolateModel(functions, null, 3);
      await heavyTask(isolateModel);

      final user = User.fromMap(storageService.getObject('user')!);
      final seller = storageService.getString('username');
      final sections = await queryLoaderService.getResults('home', [seller]);

      emit(HomeSuccess(
          user: user,
          sections: sections,
        ));
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
