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
  final int codcliente;
  final String codbodega;
  final String codprecio;

  ProductArgument(
      {required this.codcliente,
      required this.codbodega,
      required this.codprecio});

  factory ProductArgument.fromJson(Map<String, dynamic> json) =>
      ProductArgument(
          codcliente: json['codcliente'] is String
              ? int.parse(json['codcliente'])
              : json['codcliente'],
          codbodega: json['codbodega'],
          codprecio: json['codprecio']);

  Map<String, dynamic> toMap() {
    return {
      'codcliente': codcliente,
      'codbodega': codbodega,
      'codprecio': codprecio
    };
  }
}
