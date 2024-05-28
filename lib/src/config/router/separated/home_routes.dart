//utils
import '../../../utils/constants/strings.dart';
//router
import '../route_type.dart';
//widgets
import '../../../presentation/widgets/atomsbox.dart';
//views
import '../../../presentation/views/user/home/index.dart';

Map<String, RouteType> homeRoutes = {
  AppRoutes.home: (context, settings) => AppGlobalBackground.squared(
      opacity: 0.1, hideBottomNavigationBar: false, child: const IndexView()),
};
