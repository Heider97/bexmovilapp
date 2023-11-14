import 'package:flutter/material.dart';

//config
import '../../utils/constants/strings.dart';

//SCREENS
//global
import '../../presentation/widgets/global/global_background.dart';

import '../../presentation/views/global/permission_view.dart';
import '../../presentation/views/global/undefined_view.dart';
import '../../presentation/views/global/splash_view.dart';
import '../../presentation/views/global/politics_view.dart';
import '../../presentation/views/global/login_view.dart';
import '../../presentation/views/global/select_enterprise_view.dart';
//user
import '../../presentation/views/user/productivity/index.dart';
import '../../presentation/views/user/schedule/index.dart';
import '../../presentation/views/user/home/index.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.splashRoute:
      return MaterialPageRoute(
          builder: (context) => const GlobalBackground(child: SplashView()));
    case Routes.selectEnterpriseRoute:
      return MaterialPageRoute(
          builder: (context) =>
              const GlobalBackground(child: SelectEnterpriseView()));
    case Routes.politicsRoute:
      return MaterialPageRoute(builder: (context) => const PoliticsView());
    case Routes.permissionRoute:
      return MaterialPageRoute(
          builder: (context) => const RequestPermissionView());
    // case Routes.companyRoute:
    // return MaterialPageRoute(
    //     builder: (context) => const GlobalBackground(child: InitialView()))
    case Routes.loginRoute:
      return MaterialPageRoute(
          builder: (context) => const GlobalBackground(child: LoginView()));
    // case Routes.homeRoute:
    //  return MaterialPageRoute(builder: (context) => const HomeView());
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
    case Routes.productivityRoute:
      return MaterialPageRoute(builder: (context) => ProductivityView());
    default:
      return MaterialPageRoute(
          builder: (context) => UndefinedView(
                name: settings.name,
              ));
  }
}
