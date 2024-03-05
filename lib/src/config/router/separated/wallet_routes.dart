//utils
import '../../../utils/constants/strings.dart';
//router
import '../route_type.dart';
//domain
import '../../../domain/models/arguments.dart';
//background
import '../../../presentation/widgets/global/app_global_background.dart';
//views
import '../../../presentation/views/user/wallet/pages/dashboard.dart';
import '../../../presentation/views/user/wallet/pages/clients.dart';

Map<String, RouteType> walletRoutes = {
  AppRoutes.dashboardWallet: (context, settings) =>
      AppGlobalBackground.normal(child: const WalletDashboardView()),
  AppRoutes.clientsWallet: (context, settings) => AppGlobalBackground.squared(
      opacity: 0.1,
      hideBottomNavigationBar: true,
      child: WalletClientsView(
        walletArgument: settings.arguments as WalletArgument,
      )),
};
