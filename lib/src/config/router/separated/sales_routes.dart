//utils

import '../../../utils/constants/strings.dart';
//router
import '../route_type.dart';
//views
import '../../../presentation/widgets/global/app_global_background.dart';
import '../../../presentation/views/user/sale/pages/routers.dart';
import '../../../presentation/views/user/sale/pages/clients.dart';

Map<String, RouteType> salesRoutes = {
  AppRoutes.routersSale: (context, settings) =>
      AppGlobalBackground.normal(child: const RoutersPage()),
  AppRoutes.clientsSale: (context, settings) => AppGlobalBackground.normal(
      child: ClientsPage(codeRouter: settings.arguments as String?)),
};
