//utils
import 'package:bexmovil/src/domain/models/arguments.dart';
import 'package:bexmovil/src/presentation/views/user/sale/pages/clients_map.dart';
import 'package:bexmovil/src/presentation/views/user/sale/pages/shopping_cart.dart';
import 'package:bexmovil/src/presentation/views/user/sale/pages/warehouses.dart';

import '../../../presentation/views/user/sale/pages/products.dart';
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
  AppRoutes.routersSale: (context, settings) => AppGlobalBackground.sales(
      hideAppBar: false,
      hideBottomNavigationBar: true,
      child: const RoutersPage()),
  AppRoutes.clientsSale: (context, settings) => AppGlobalBackground.sales(
      hideAppBar: false,
      hideBottomNavigationBar: true,
      child: ClientsPage(codeRouter: settings.arguments as String?)),
  AppRoutes.filtersSale: (context, settings) =>
      AppGlobalBackground.sales(child: const FiltersSalePage()),
  AppRoutes.saleMap: (context, settings) => AppGlobalBackground.squared(
      hideBottomNavigationBar: true,
      opacity: 0.1,
      child: MapClients(codeRouter: settings.arguments as String)),
  AppRoutes.warehousesSale: (context, settings) => AppGlobalBackground.warehouses(
      hideAppBar: false,
      hideBottomNavigationBar: true,
      child: WarehousesPage(arguments: settings.arguments as WarehouseArgument)),
  AppRoutes.productsSale: (context, settings) => AppGlobalBackground.products(
      hideAppBar: false,
      hideBottomNavigationBar: true,
      opacity: 0.1,
      child: ProductsView(arguments: settings.arguments as ProductArgument)),
  AppRoutes.shoppingCart: (context, settings) => AppGlobalBackground.squared(
      hideBottomNavigationBar: true,
      opacity: 0.1,
      child: const ShoppingCartView())
};
