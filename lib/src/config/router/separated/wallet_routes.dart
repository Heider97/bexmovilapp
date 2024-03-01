//utils
import '../../../utils/constants/strings.dart';
//router
import '../route_type.dart';
//domain
import '../../../domain/models/arguments.dart';
//views
import '../../../presentation/widgets/global/global_background.dart';
import '../../../presentation/widgets/global/global_background_square.dart';
import '../../../presentation/views/user/wallet/pages/dashboard.dart';
import '../../../presentation/views/user/wallet/pages/clients.dart';

Map<String, RouteType> walletRoutes = {
  AppRoutes.dashboardWallet: (context, settings) =>
      const GlobalBackground(child: WalletDashboardView()),
  AppRoutes.clientsWallet: (context, settings) => GlobalBackgroundSquare(
      opacity: 0.1,
      hideBottomNavigationBar: true,
      child: WalletClientsView(
        walletArgument: settings.arguments as WalletArgument,
      )),
};
