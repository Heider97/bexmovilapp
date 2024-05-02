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
  final String codrouter;
  final String codcliente;

  WarehouseArgument({required this.codrouter, required this.codcliente});

  WarehouseArgument fromJson(Map<String, dynamic> json) {
    return WarehouseArgument(
        codrouter: json['codrouter'], codcliente: json['codcliente']);
  }
}

class ProductArgument {
  final String codcliente;
  final String codbodega;
  final String codprecio;

  ProductArgument(
      {required this.codcliente,
      required this.codbodega,
      required this.codprecio});

  ProductArgument fromJson(Map<String, dynamic> json) {
    return ProductArgument(
        codcliente: json['codcliente'],
        codbodega: json['codbodega'],
        codprecio: json['codprecio']);
  }
}
