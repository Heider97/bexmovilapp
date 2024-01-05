import 'package:bexmovil/src/presentation/views/user/search_view.dart';
import 'package:bexmovil/src/presentation/views/user/wallet/char_details_view.dart';
import 'package:bexmovil/src/presentation/views/user/wallet/wallet_dashboard_view.dart';
import 'package:bexmovil/src/presentation/views/user/wallet/wallet_process_view.dart';
import 'package:flutter/material.dart';

//config
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
import '../../presentation/views/user/schedule/index.dart';

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
                child: CodeVerificationView(),
                hideBottomNavigationBar: true,
              ));
    case Routes.recoverPassword:
      return MaterialPageRoute(
          builder: (_) => const GlobalBackgroundSquare(
                opacity: 0.1,
                hideBottomNavigationBar: true,
                child: RecoverPasswordView(),
              ));
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

    case Routes.calendarRoute:
      return MaterialPageRoute(builder: (context) => const ScheduleView());

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

    /*  case Routes.productivityRoute:
      return MaterialPageRoute(builder: (context) => ProductivityView()); */
    default:
      return MaterialPageRoute(
          builder: (context) => UndefinedView(
                name: settings.name,
              ));
  }
}
