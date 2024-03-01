//utils
import '../../../utils/constants/strings.dart';
//router
import '../route_type.dart';
//views
import '../../../presentation/views/user/home/index.dart';
import '../../../presentation/views/global/sync_view.dart';

Map<String, RouteType> homeRoutes = {
  AppRoutes.home: (context, settings) =>
      const HomeView(),
  AppRoutes.sync: (contetx, settings) => const SyncView()
};
