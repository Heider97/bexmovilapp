
import 'package:BexMovil/src/presentation/views/schedule/index.dart';
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
import '../../presentation/views/user/category/index.dart';
import '../../presentation/views/user/product/index.dart';
import '../../presentation/views/user/productivity/index.dart';

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
    case categoryRoute:
      return MaterialPageRoute(builder: (context) => CategoryView(categoryId: settings.arguments as int));
    case productRoute:
      return MaterialPageRoute(builder: (context) => ProductView(productId: settings.arguments as int));
    case calendarRoute:
      return MaterialPageRoute(builder: (context) => const ScheduleView());
    case productivityRoute:
      return MaterialPageRoute(builder: (context) => ProductivityView());
    default:
      return MaterialPageRoute(
          builder: (context) => UndefinedView(
                name: settings.name,
              ));
  }
}
