import 'package:bexmovil/src/domain/models/responses/kpi_response.dart';
import 'package:bexmovil/src/presentation/cubits/base/base_cubit.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';

//utils
import '../../../utils/constants/strings.dart';

//domain
import '../../../domain/models/user.dart';
import '../../../domain/models/application.dart';
import '../../../domain/models/feature.dart';
import '../../../domain/models/kpi.dart';
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


      emit(HomeSuccess(
          user: user,
          features: features,
          kpisOneLine: kpisOneLine,
          kpisSecondLine: kpisSecondLine));
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
