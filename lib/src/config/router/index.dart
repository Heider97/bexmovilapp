import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';


//config
import '../../utils/constants/strings.dart';

//SCREENS
//global
import '../../presentation/views/global/initial_view.dart';
import '../../presentation/views/global/permission_view.dart';
import '../../presentation/views/global/login_view.dart';
import '../../presentation/views/global/undefined_view.dart';
import '../../presentation/views/global/splash_view.dart';
import '../../presentation/views/global/politics_view.dart';

//user
import '../../presentation/views/user/home/index.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case splashRoute:
      return MaterialPageRoute(builder: (context) => const SplashView());
    case politicsRoute:
      return MaterialPageRoute(builder: (context) => const PoliticsView());
    case permissionRoute:
      return MaterialPageRoute(
          builder: (context) => const RequestPermissionView());
    case companyRoute:
      return MaterialPageRoute(builder: (context) => const InitialView());
    case loginRoute:
      return MaterialPageRoute(builder: (context) => const LoginView());
    case homeRoute:
      return MaterialPageRoute(builder: (context) => const HomeView());
    default:
      return MaterialPageRoute(
          builder: (context) => UndefinedView(
                name: settings.name,
              ));
  }
}
