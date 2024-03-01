//utils

import '../../../utils/constants/strings.dart';
//router
import '../route_type.dart';
//views
import '../../../presentation/views/global/splash_view.dart';
import '../../../presentation/views/global/permission_view.dart';
import '../../../presentation/views/global/politics_view.dart';
import '../../../presentation/views/global/login/index.dart';
import '../../../presentation/views/global/enterprise/index.dart';

Map<String, RouteType> authRoutes = {
  AppRoutes.splash: (context, settings) => const SplashView(),
  AppRoutes.politics: (context, settings) => const PoliticsView(),
  AppRoutes.company: (context, settings) => const SelectEnterpriseView(),
  AppRoutes.permission: (context, settings) => const RequestPermissionView(),
  AppRoutes.login: (context, settings) => const LoginView(),
};