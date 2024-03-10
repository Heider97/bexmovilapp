import 'package:equatable/equatable.dart';
import 'package:collection/collection.dart';

//cubit
import '../../../domain/models/requests/module_request.dart';
import '../base/base_cubit.dart';

//utils
import '../../../utils/constants/strings.dart';
import '../../../utils/resources/data_state.dart';

//domain
import '../../../domain/models/user.dart';
import '../../../domain/models/application.dart';
import '../../../domain/models/feature.dart';
import '../../../domain/models/kpi.dart';
import '../../../domain/models/isolate.dart';
//requests
import '../../../domain/models/requests/functionality_request.dart';
import '../../../domain/models/requests/filter_request.dart';
import '../../../domain/models/requests/graphic_request.dart';
import '../../../domain/models/requests/kpi_request.dart';
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
    final response = await apiRepository.modules(
        request:
            ModuleRequest(codvendedor: storageService.getString('username')!));

    if (response is DataSuccess) {
      await databaseRepository.init();
      if (response.data != null && response.data!.modules != null) {
        var modules = response.data!.modules;
        await databaseRepository.insertModules(modules!);
        for (var module in modules) {
          if (module.components != null) {
            await databaseRepository.insertComponents(module.components!);
            for (var component in module.components!) {
              await databaseRepository.insertQueries(component.queries!);
            }
          }
        }
      }
    } else {
      emit(HomeFailed(
        error: 'modules-${response.data!.message}',
      ));
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

  Future<void> getFeatures() async {
    final response = await apiRepository.features();

    if (response is DataSuccess && response.data != null) {
      await databaseRepository.insertFeatures(response.data!.features);
    } else {
      emit(HomeFailed(error: 'features-${response.data!.message}'));
    }
  }

  Future<void> getKpis() async {
    final response = await apiRepository.kpis(
        request:
            KpiRequest(codvendedor: storageService.getString('username')!));

    if (response is DataSuccess && response.data != null) {
      await databaseRepository.insertKpis(response.data!.kpis!);
    } else {
      emit(HomeFailed(error: 'kpis-${response.data!.message}'));
    }
  }

  Future<void> getFunctionalities() async {
    final response = await apiRepository.functionalities(
        request: FunctionalityRequest(
            codvendedor: storageService.getString('username')!));

    if (response is DataSuccess && response.data != null) {
      await databaseRepository
          .insertApplications(response.data!.functionalities!);
    } else {
      emit(HomeFailed(error: 'functionalities-${response.data!.message}'));
    }
  }

  Future<void> getGraphics() async {
    final response = await apiRepository.graphics(
        request:
            GraphicRequest(codvendedor: storageService.getString('username')!));
    if (response is DataSuccess && response.data != null) {
      await databaseRepository.insertGraphics(response.data!.graphics!);
    } else {
      emit(HomeFailed(error: 'graphics-${response.data!.message}'));
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

      // var kpisOneLine = await databaseRepository.getKpisByLine('1');
      // var kpisSecondLine = await databaseRepository.getKpisByLine('2');

      var f = await queryLoaderService.getResults(
          List<Feature>, 'home', 'features', [], true);
      var features = (f)?.map((e) => e as Feature).toList();

      var a = await queryLoaderService.getResults(
          List<Application>, 'home', 'applications', [], true);
      var applications = (a)?.map((e) => e as Application).toList();

      var k1 = await queryLoaderService.getResults(
          List<Kpi>, 'home', 'kpi', ['1'], true);
      var kpisOneLine = (k1)?.map((e) => e as Kpi).toList();

      var k2 = await queryLoaderService.getResults(
          List<Kpi>, 'home', 'kpi', ['2'], true);
      var kpisSecondLine = (k2)?.map((e) => e as Kpi).toList();

      List<List<Kpi>> kpisSlidableOneLine = [];
      List<List<Kpi>> kpisSlidableSecondLine = [];

      if (kpisOneLine != null) {
        final duplicatesOneLine = groupBy(
          kpisOneLine,
          (kpi) => kpi.type,
        )
            .values
            .where((list) => list.length > 1)
            .map((list) => list.first.type)
            .toList();

        if (duplicatesOneLine.isNotEmpty) {
          for (var dsl in duplicatesOneLine) {
            kpisOneLine.removeWhere((element) => element.type == dsl);
            kpisSlidableOneLine
                .add(kpisOneLine.where((kpi) => kpi.type == dsl).toList());
          }
        }
      }

      if (kpisSecondLine != null) {
        final duplicatesSecondLine = groupBy(
          kpisSecondLine,
          (kpi) => kpi.type,
        )
            .values
            .where((list) => list.length > 1)
            .map((list) => list.first.type)
            .toList();

        if (duplicatesSecondLine.isNotEmpty) {
          for (var dsl in duplicatesSecondLine) {
            kpisSlidableSecondLine
                .add(kpisSecondLine.where((kpi) => kpi.type == dsl).toList());
            kpisSecondLine.removeWhere((element) => element.type == dsl);
          }
        }
      }

      emit(HomeSuccess(
          user: user,
          features: features,
          kpisOneLine: kpisOneLine,
          kpisSlidableOneLine: kpisSlidableOneLine,
          kpisSecondLine: kpisSecondLine,
          kpisSlidableSecondLine: kpisSlidableSecondLine,
          applications: applications));
    });
  }

  Future<void> sync() async {
    if (isBusy) return;

    await run(() async {
      emit(const HomeSynchronizing());

      var functions = [
        getModules,
        getConfigs,
        getFeatures,
        getKpis,
        getFunctionalities,
        getGraphics,
        getFilters
      ];

      var isolateModel = IsolateModel(functions, null, 7);
      await heavyTask(isolateModel);

      final user = User.fromMap(storageService.getObject('user')!);
      var features = await databaseRepository.getAllFeatures();
      var applications = await databaseRepository.getAllApplications();
      var kpisOneLine = await databaseRepository.getKpisByLine('1');
      var kpisSecondLine = await databaseRepository.getKpisByLine('2');

      List<List<Kpi>> kpisSlidableOneLine = [];
      List<List<Kpi>> kpisSlidableSecondLine = [];

      final duplicatesOneLine = groupBy(
        kpisOneLine,
        (kpi) => kpi.type,
      )
          .values
          .where((list) => list.length > 1)
          .map((list) => list.first.type)
          .toList();

      final duplicatesSecondLine = groupBy(
        kpisSecondLine,
        (kpi) => kpi.type,
      )
          .values
          .where((list) => list.length > 1)
          .map((list) => list.first.type)
          .toList();

      if (duplicatesOneLine.isNotEmpty) {
        for (var dsl in duplicatesOneLine) {
          kpisOneLine.removeWhere((element) => element.type == dsl);
          kpisSlidableOneLine
              .add(kpisOneLine.where((kpi) => kpi.type == dsl).toList());
        }
      }

      if (duplicatesSecondLine.isNotEmpty) {
        for (var dsl in duplicatesSecondLine) {
          kpisSlidableSecondLine
              .add(kpisSecondLine.where((kpi) => kpi.type == dsl).toList());
          kpisSecondLine.removeWhere((element) => element.type == dsl);
        }
      }

      emit(HomeSuccess(
          user: user,
          features: features,
          kpisOneLine: kpisOneLine,
          kpisSlidableOneLine: kpisSlidableOneLine,
          kpisSecondLine: kpisSecondLine,
          kpisSlidableSecondLine: kpisSlidableSecondLine,
          applications: applications));
    });
  }

  Future<void> logout() async {
    await Future.wait([
      databaseRepository.emptyFeatures(),
      databaseRepository.emptyKpis(),
      databaseRepository.emptyApplications()
      //DELETE  DATABASE INFORMATION
    ]);

    storageService.remove('token');
    navigationService.replaceTo(AppRoutes.login);
  }
}
