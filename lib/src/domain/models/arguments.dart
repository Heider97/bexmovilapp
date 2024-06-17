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
  final int codcliente;
  final String codprecio;
  final String? codbodega;

  WarehouseArgument(
      {required this.codrouter,
      required this.codcliente,
      required this.codprecio,
      this.codbodega});

  factory WarehouseArgument.fromJson(Map<String, dynamic> json) =>
      WarehouseArgument(
          codrouter: json['codrouter'],
          codcliente: json['codcliente'],
          codprecio: json['codprecio'],
          codbodega: json['codbodeha']);
}

class ProductArgument {
  final Client? client;

  final String codbodega;
  final String codprecio;

  ProductArgument(
      {required this.client, required this.codbodega, required this.codprecio});

  factory ProductArgument.fromJson(Map<String, dynamic> json) {
    print('****json***');
    print(json);
    return ProductArgument(
        client: json['client'] != null ? Client.fromJson(json['client']) : null,
        codbodega: json['codbodega'],
        codprecio: json['codprecio']);
  }

  Map<String, dynamic> toMap() {
    return {'client': client, 'codbodega': codbodega, 'codprecio': codprecio};
  }
}
