//utils
import '../../../utils/constants/strings.dart';
//router
import '../route_type.dart';
//views
import '../../../presentation/widgets/global/global_background.dart';
import '../../../presentation/views/user/wallet/pages/dashboard.dart';

Map<String, RouteType> walletRoutes = {
  AppRoutes.dashboardWallet: (context, arguments) =>
      const GlobalBackground(child: WalletDashboardView()),
};
