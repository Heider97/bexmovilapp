//utils

import '../../../utils/constants/strings.dart';
//router
import '../route_type.dart';
//views
import '../../../presentation/widgets/global/global_background.dart';
import '../../../presentation/views/user/sale/pages/routers.dart';
import '../../../presentation/views/user/sale/pages/clients.dart';

Map<String, RouteType> salesRoutes = {
  AppRoutes.routersSale: (context, settings) =>
      const GlobalBackground(child: RoutersPage()),
  AppRoutes.clientsSale: (context, settings) =>
      const GlobalBackground(child: ClientsPage()),
};
