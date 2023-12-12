import 'package:bexmovil/src/presentation/views/user/calendar/index.dart';
import 'package:flutter/material.dart';

//config
import '../../presentation/views/global/code_create_meet.dart';
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
              opacity: 0.1, child: CodeFormRequestView()));
    case Routes.codeValidation:
      return MaterialPageRoute(
          builder: (_) => const GlobalBackgroundSquare(
              opacity: 0.1, child: CodeVerificationView()));
    case Routes.recoverPassword:
      return MaterialPageRoute(
          builder: (_) => const GlobalBackgroundSquare(
              opacity: 0.1, child: RecoverPasswordView()));
    case Routes.codecreatemeet:
    return MaterialPageRoute(
      builder: (_) =>  CodeCreateMeet()
    );          
    case Routes.politicsRoute:
      return MaterialPageRoute(builder: (context) => const PoliticsView());
    case Routes.permissionRoute:
      return MaterialPageRoute(
          builder: (context) => const RequestPermissionView());
    case Routes.selectEnterpriseRoute:
      return MaterialPageRoute(
        builder: (context) => const GlobalBackground(child: SelectEnterpriseView()));
    case Routes.syncRoute:
      return MaterialPageRoute(
        builder: (context) => const GlobalBackground(child: SyncView()));
    case Routes.loginRoute:
      return MaterialPageRoute(
          builder: (context) => const GlobalBackground(child: LoginView()));
    case Routes.homeRoute:
     return MaterialPageRoute(builder: (context) =>  const GlobalBackground(child: HomeView()));
    //  case Routes.categoryRoute:
    //   return MaterialPageRoute(
    //       builder: (context) =>
    //           CategoryView(categoryId: settings.arguments as int));
    // case Routes.productRoute:
    //   return MaterialPageRoute(
    //       builder: (context) =>
    //           ProductView(productId: settings.arguments as int));
    case Routes.calendarRoute:
      return MaterialPageRoute(builder: (context) => const ScheduleView());
    /*  case Routes.productivityRoute:
      return MaterialPageRoute(builder: (context) => ProductivityView()); */
    default:
      return MaterialPageRoute(
          builder: (context) => UndefinedView(
                name: settings.name,
              ));
  }
}
