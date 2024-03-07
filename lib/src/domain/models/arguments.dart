import 'client.dart';

class WalletArgument {
  WalletArgument({required this.type, this.client});
  final String type;
  final Client? client;
}

class NavigationArgument {
  NavigationArgument({ required this.clients, required this.nearest });
  List<Client> clients;
  bool nearest;
}
