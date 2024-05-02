import 'client.dart';

class WalletArgument {
  WalletArgument({required this.type, this.client});
  final String type;
  final Client? client;
}

class NavigationArgument {
  NavigationArgument({required this.clients, required this.nearest});
  List<Client> clients;
  bool nearest;
}

class WarehouseArgument {
  final String codbodega;
  final String codprecio;

  WarehouseArgument({required this.codbodega, required this.codprecio});

  WarehouseArgument fromJson(Map<String, dynamic> json) {
    return WarehouseArgument(
        codbodega: json['codbodega'], codprecio: json['codprecio']);
  }
}
