import 'package:equatable/equatable.dart';

//utils
import '../../../utils/constants/strings.dart';
import '../base/base_cubit.dart';

//service
import '../../../services/storage.dart';
import '../../../services/navigation.dart';

part 'politics_state.dart';

class PoliticsCubit extends BaseCubit<PoliticsState> {
  final LocalStorageService storageService;
  final NavigationService navigationService;

  PoliticsCubit(this.storageService, this.navigationService)
      : super(PoliticsSuccess(token: storageService.getString('token')));

  Future<void> goTo() async {
    if (isBusy) return;

    await run(() async {
      try {
        storageService.setBool('first_time', true);
        var token = storageService.getString('token');
        String route;

        if (token != null) {
          route = AppRoutes.home;
        } else {
          route = AppRoutes.permission;
        }

        emit(PoliticsSuccess(
            token: storageService.getString('token'), route: route));
      } catch (e) {
        emit(PoliticsFailed(error: e.toString()));
      }
    });
  }
}
