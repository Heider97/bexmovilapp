//utils
import 'package:bexmovil/src/presentation/views/user/sale/pages/clients_map.dart';
import 'package:bexmovil/src/presentation/views/user/sale/pages/select_products.dart';

import '../../../utils/constants/strings.dart';
//router
import '../route_type.dart';
//widgets
import '../../../presentation/widgets/atomsbox.dart';
//views
import '../../../presentation/views/user/sale/pages/routers.dart';
import '../../../presentation/views/user/sale/pages/clients.dart';
import '../../../presentation/views/user/sale/pages/filters.dart';

Map<String, RouteType> salesRoutes = {
  AppRoutes.routersSale: (context, settings) =>
      AppGlobalBackground.normal(hideAppBar: false, child: const RoutersPage()),
  AppRoutes.clientsSale: (context, settings) => AppGlobalBackground.normal(
      hideAppBar: false,
      child: ClientsPage(codeRouter: settings.arguments as String?)),
  AppRoutes.filtersSale: (context, settings) =>
      AppGlobalBackground.normal(child: const FiltersSalePage()),
  AppRoutes.saleMap: (context, settings) => AppGlobalBackground.squared(
      hideBottomNavigationBar: true,
      opacity: 0.1,
      child: MapAvailableCars(codeRouter: settings.arguments as String)),
  AppRoutes.selectProducts: (context, settings) => AppGlobalBackground.squared(
      hideBottomNavigationBar: true,
      opacity: 0.1,
      child: const SelectProductsView())
};
