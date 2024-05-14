//domain
import '../../../domain/models/arguments.dart';
import '../../../domain/models/router.dart';
//utils
import '../../../utils/constants/strings.dart';
//router
import '../route_type.dart';
//widgets
import '../../../presentation/widgets/atomsbox.dart';
//views
import '../../../presentation/views/user/sale/pages/routers.dart';
import '../../../presentation/views/user/sale/pages/clients.dart';
import '../../../presentation/views/user/sale/pages/clients_map.dart';
import '../../../presentation/views/user/sale/pages/filters.dart';
import '../../../presentation/views/user/sale/pages/products.dart';
import '../../../presentation/views/user/sale/pages/shopping_cart.dart';

Map<String, RouteType> salesRoutes = {
  AppRoutes.routersSale: (context, settings) => AppGlobalBackground.sales(
      hideAppBar: false,
      hideBottomNavigationBar: true,
      child: const RoutersPage()),
  AppRoutes.clientsSale: (context, settings) => AppGlobalBackground.sales(
      hideAppBar: false,
      hideBottomNavigationBar: true,
      child: ClientsPage(router: settings.arguments as Router)),
  AppRoutes.filtersSale: (context, settings) =>
      AppGlobalBackground.sales(child: const FiltersSalePage()),
  AppRoutes.saleMap: (context, settings) => AppGlobalBackground.squared(
      hideBottomNavigationBar: true,
      opacity: 0.1,
      child: MapClients(router: settings.arguments as Router)),
  AppRoutes.productsSale: (context, settings) => AppGlobalBackground.products(
      hideAppBar: false,
      hideBottomNavigationBar: true,
      opacity: 0.1,
      child: ProductsView(arguments: settings.arguments as ProductArgument)),
  AppRoutes.cartSale: (context, settings) => AppGlobalBackground.sales(
      hideAppBar: false,
      hideBottomNavigationBar: true,
      opacity: 0.1,
      child: const ShoppingCartView()),
};
