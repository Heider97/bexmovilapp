import 'package:bexmovil/src/presentation/views/user/calendar/index.dart';
import 'package:bexmovil/src/presentation/views/user/sale/details_sale.dart';
import 'package:bexmovil/src/presentation/views/user/sale/index.dart';
import 'package:bexmovil/src/presentation/views/user/wallet/pages/search.dart';
import 'package:bexmovil/src/presentation/views/user/wallet/pages/chart_details.dart';
import 'package:bexmovil/src/presentation/views/user/wallet/pages/dashboard.dart';
import 'package:bexmovil/src/presentation/views/user/wallet/wallet_details_screen.dart';
import 'package:bexmovil/src/presentation/views/user/wallet/pages/notification.dart';
import 'package:bexmovil/src/presentation/views/user/wallet/wallet_process_view.dart';
import 'package:flutter/material.dart';

//config
import '../../presentation/views/global/code_create_meet.dart';
import '../../presentation/views/user/sale/history_sales.dart';
import '../../utils/constants/strings.dart';

//SCREENS
//global
import '../../presentation/views/global/sync_view.dart';
import '../../presentation/views/global/code_form_request_view.dart';
import '../../presentation/views/global/code_verification_view.dart';
import '../../presentation/views/global/login_view.dart';
import '../../presentation/views/global/recover_password_view.dart';
import '../../presentation/views/global/select_enterprise_view.dart';
import '../../presentation/views/global/permission_view.dart';
import '../../presentation/views/global/undefined_view.dart';
import '../../presentation/views/global/splash_view.dart';
import '../../presentation/views/global/politics_view.dart';

//user
import '../../presentation/views/user/home/index.dart';

//widgets
import '../../presentation/widgets/global/global_background.dart';
import '../../presentation/widgets/global/global_background_square.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.splashRoute:
      return MaterialPageRoute(
          builder: (context) => const GlobalBackground(child: SplashView()));
    case Routes.codeFormRequest:
      return MaterialPageRoute(
          builder: (_) => const GlobalBackgroundSquare(
              hideBottomNavigationBar: true,
              opacity: 0.1,
              child: CodeFormRequestView()));
    case Routes.codeValidation:
      return MaterialPageRoute(
          builder: (_) => const GlobalBackgroundSquare(
                opacity: 0.1,
                hideBottomNavigationBar: true,
                child: CodeVerificationView(),
              ));
    case Routes.recoverPassword:
      return MaterialPageRoute(
          builder: (_) => const GlobalBackgroundSquare(
              opacity: 0.1,
              hideBottomNavigationBar: true,
              child: RecoverPasswordView()));
    case Routes.codecreatemeet:
      return MaterialPageRoute(builder: (_) => const CodeCreateMeet());
    case Routes.politicsRoute:
      return MaterialPageRoute(builder: (context) => const PoliticsView());
    case Routes.permissionRoute:
      return MaterialPageRoute(
          builder: (context) => const RequestPermissionView());
    case Routes.selectEnterpriseRoute:
      return MaterialPageRoute(
          builder: (context) =>
              const GlobalBackground(child: SelectEnterpriseView()));
    case Routes.syncRoute:
      return MaterialPageRoute(
          builder: (context) => const GlobalBackground(child: SyncView()));
    case Routes.loginRoute:
      return MaterialPageRoute(
          builder: (context) => const GlobalBackground(child: LoginView()));
    case Routes.homeRoute:
      return MaterialPageRoute(
          builder: (context) =>
              const GlobalBackgroundSquare(opacity: 0.1, child: HomeView()));
    case Routes.searchPage:
      return MaterialPageRoute(
          builder: (context) => const GlobalBackgroundSquare(
              hideBottomNavigationBar: true,
              opacity: 0.1,
              child: SearchView(
                tables: ['tblmproducto', 'tblmcliente'],
              )));
    case Routes.wallet:
      return MaterialPageRoute(
          builder: (context) => const GlobalBackgroundSquare(
              hideBottomNavigationBar: true,
              opacity: 0.1,
              child: WalletDashboardView()));

    case Routes.walletDetailsScreen:
      return MaterialPageRoute(
          builder: (context) => const GlobalBackgroundSquare(
              hideBottomNavigationBar: true,
              opacity: 0.1,
              child: WalletDetailsScreen()));

    case Routes.walletNotificationView:
      return MaterialPageRoute(
          builder: (context) => const GlobalBackgroundSquare(
              hideBottomNavigationBar: true,
              opacity: 0.1,
              child: WalletNotificationView()));

    case Routes.calendarRoute:
      return MaterialPageRoute(builder: (context) => const CalendarPage());

    case Routes.charDetailsRoute:
      return MaterialPageRoute(
          builder: (context) => const GlobalBackgroundSquare(
                opacity: 0.1,
                hideBottomNavigationBar: true,
                child: CharDetails(),
              ));
    case Routes.walletprocess:
      return MaterialPageRoute(
          builder: (context) => const GlobalBackgroundSquare(
                opacity: 0.1,
                hideBottomNavigationBar: true,
                child: WalletProcessView(),
              ));

    case Routes.saleRoute:
      return MaterialPageRoute(
          builder: (context) => const GlobalBackgroundSquare(
                opacity: 0.1,
                hideBottomNavigationBar: true,
                child: SalePage(),
              ));
    case Routes.detailSaleRoute:
      return MaterialPageRoute(
          builder: (context) => DetailsSale(dataSales: []));
    case Routes.historySaleRoute:
      return MaterialPageRoute(builder: (context) => const HistorySale());
    default:
      return MaterialPageRoute(
          builder: (context) => UndefinedView(
                name: settings.name,
              ));
  }
}
