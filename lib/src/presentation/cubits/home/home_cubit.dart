import 'package:equatable/equatable.dart';
import 'package:collection/collection.dart';
import 'package:bexmovil/src/presentation/cubits/base/base_cubit.dart';

//utils
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

part 'home_state.dart';

class HomeCubit extends BaseCubit<HomeState> {
  final DatabaseRepository databaseRepository;
  final LocalStorageService storageService;
  final NavigationService navigationService;

  HomeCubit(
      this.databaseRepository, this.storageService, this.navigationService)
      : super(const HomeLoading());

  Future<void> init() async {
    if (isBusy) return;

    await run(() async {
      final user = User.fromMap(storageService.getObject('user')!);
      var features = await databaseRepository.getAllFeatures();
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
      ));
    });
  }

  Future<void> logout() async {
    await Future.wait([
      //DELETE  DATABASE INFORMATION
    ]);

    storageService.remove('token');
    navigationService.replaceTo(Routes.loginRoute);
  }
}
