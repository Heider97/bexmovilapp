//utils

import '../../../utils/constants/strings.dart';
//router
import '../route_type.dart';
//views
import '../../../presentation/widgets/atomsbox.dart';
import '../../../presentation/views/user/chat/index.dart';

Map<String, RouteType> chatRoutes = {
  AppRoutes.chat: (context, settings) => AppGlobalBackground.normal(
      hideAppBar: false,
      opacity: 0.1, hideBottomNavigationBar: true, child: const ChatView()),
};
