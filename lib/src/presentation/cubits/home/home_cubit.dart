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

      print('**********');
      print(kpisOneLine);
      print(kpisSecondLine);

      // //LINE 1
      // int length1line = 0;
      // int amountWalletKpi1line = 0;
      // List<Kpi> othersKpi1Line = [];
      //
      // //LINE 2
      // int length2line = 0;
      // int amountWalletKpi2line = 0;
      // List<Kpi> othersKpi2Line = [];
      //
      // if (state.kpis != null) {
      //   //la longitud de la linea 1
      //   length1line = state.kpis!.where((kpi) => kpi.line == 1).toList().length;
      //   //wallet kpi line 1
      //   amountWalletKpi1line = state.kpis!
      //       .where((kpi) => kpi.line == 1 && kpi.type == 'wallet')
      //       .toList()
      //       .length;
      //
      //   othersKpi1Line = state.kpis!
      //       .where((kpi) => kpi.type != 'wallet' && kpi.line == 1)
      //       .toList();
      //
      //   if (amountWalletKpi1line != 0) {
      //     length1line = length1line - amountWalletKpi1line + 1;
      //   }
      //
      //   //la longitud de la linea 2
      //   length2line = state.kpis!.where((kpi) => kpi.line == 2).toList().length;
      //   //wallet kpi line 2
      //   amountWalletKpi2line = state.kpis!
      //       .where((kpi) => kpi.line == 2 && kpi.type == 'wallet')
      //       .toList()
      //       .length;
      //
      //   othersKpi2Line = state.kpis!
      //       .where((kpi) => kpi.type != 'wallet' && kpi.line == 2)
      //       .toList();
      //
      //   if (amountWalletKpi2line != 0) {
      //     length2line = length2line - amountWalletKpi2line + 1;
      //   }
      // }

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
