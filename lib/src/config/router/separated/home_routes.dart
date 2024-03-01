//utils

import '../../../utils/constants/strings.dart';
//router
import '../route_type.dart';
//views
import '../../../presentation/widgets/global/global_background.dart';
import '../../../presentation/widgets/global/global_background_square.dart';
import '../../../presentation/views/user/home/index.dart';

Map<String, RouteType> homeRoutes = {
  AppRoutes.home: (context, settings) =>
      const GlobalBackgroundSquare(opacity: 0.1, child: HomeView()),
};
