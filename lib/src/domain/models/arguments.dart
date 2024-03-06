import 'client.dart';

class WalletArgument {
  WalletArgument({required this.type});
  final String type;
}

class NavigationArgument {
  NavigationArgument({ required this.clients, required this.nearest });
  List<Client> clients;
  bool nearest;
}
