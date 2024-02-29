import 'package:bexmovil/src/domain/repositories/api_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:collection/collection.dart';
import 'package:bexmovil/src/presentation/cubits/base/base_cubit.dart';

//utils
import '../../../domain/models/isolate.dart';
import '../../../domain/models/requests/functionality_request.dart';
import '../../../domain/models/requests/graphic_request.dart';
import '../../../domain/models/requests/kpi_request.dart';
import '../../../utils/constants/strings.dart';

//domain
import '../../../domain/models/user.dart';
import '../../../domain/models/application.dart';
import '../../../domain/models/feature.dart';
import '../../../domain/models/kpi.dart';
import '../../../domain/models/responses/kpi_response.dart';
import '../../../domain/repositories/database_repository.dart';

//service
import '../../../services/storage.dart';
import '../../../services/navigation.dart';
import '../../../utils/resources/data_state.dart';

part 'home_state.dart';

class HomeCubit extends BaseCubit<HomeState> {
  final DatabaseRepository databaseRepository;
  final ApiRepository apiRepository;
  final LocalStorageService storageService;
  final NavigationService navigationService;

  HomeCubit(this.databaseRepository, this.apiRepository, this.storageService,
      this.navigationService)
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

  Future<void> getFeatures() async {
    final response = await apiRepository.features();

    if (response is DataSuccess) {
      await databaseRepository.insertFeatures(response.data!.features);
    } else {
      emit(HomeFailed(error: 'features-${response.data!.message}'));
    }
  }

  Future<void> getKpis() async {
    final response = await apiRepository.kpis(
        request:
            KpiRequest(codvendedor: storageService.getString('username')!));

    if (response is DataSuccess) {
      await databaseRepository.insertKpis(response.data!.kpis!);
    } else {
      emit(HomeFailed(error: 'kpis-${response.data!.message}'));
    }
  }

  Future<void> getFunctionalities() async {
    final response = await apiRepository.functionalities(
        request: FunctionalityRequest(
            codvendedor: storageService.getString('username')!));

    if (response is DataSuccess) {
      await databaseRepository
          .insertApplications(response.data!.functionalities!);
    } else {
      emit(HomeFailed(error: 'functionalities-${response.data!.message}'));
    }
  }

  Future<void> getGraphics() async {
    final response = await apiRepository.graphics(
        request: GraphicRequest(
            codvendedor: storageService!.getString('username')!));

    if (response is DataSuccess) {
      await databaseRepository.insertGraphics(response.data!.graphics!);
    } else {
      emit(HomeFailed(error: 'graphics-${response.data!.message}'));
    }
  }

  Future<void> init() async {
    if (isBusy) return;

    await run(() async {
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

  Future<void> sync() async {
    if (isBusy) return;

    await run(() async {
      emit(const HomeLoading());

      var functions = [
        getConfigs,
        getFeatures,
        getKpis,
        getFunctionalities,
        getGraphics
      ];

      var isolateModel = IsolateModel(functions, null, 5);
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
    navigationService.replaceTo(Routes.loginRoute);
  }
}
