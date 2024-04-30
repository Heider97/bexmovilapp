//utils

import '../../../utils/constants/strings.dart';
//router
import '../route_type.dart';
//views
import '../../../presentation/widgets/atomsbox.dart';
import '../../../presentation/views/user/chat/index.dart';

Map<String, RouteType> chatRoutes = {
  AppRoutes.chat: (context, settings) => AppGlobalBackground.squared(
      opacity: 0.1, hideBottomNavigationBar: false, child: const ChatView()),
};
