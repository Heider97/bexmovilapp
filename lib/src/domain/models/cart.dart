const String tableCart = 'app_cart';

class CartFields {
  static final List<String> values = [
    id,
    codrouter,
    codclient,
    codproduct,
    state,
    date
  ];

  static const String id = 'id';
  static const String codrouter = 'codrouter';
  static const String codclient = 'codclient';
  static const String codproduct = 'codproduct';
  static const String state = 'state';
  static const String date = 'date';
}

class Cart {
  int? id;
  String? codrouter;
  String? codclient;
  String? codproduct;
  String? state;
  String? date;

  Cart(
      {this.id,
      this.codrouter,
      this.codclient,
      this.codproduct,
      this.state,
      this.date});

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        id: json['id'],
        codrouter: json['codrouter'],
        codclient: json['codclient'],
        codproduct: json['codproduct'],
        state: json['state'],
        date: json['date'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'codrouter': codrouter,
        'codclient': codclient,
        'codproduct': codproduct,
        'state': state,
        'date': date,
      };
}
