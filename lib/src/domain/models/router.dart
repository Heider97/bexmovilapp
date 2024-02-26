const String tableRouter = 'tblmrutero';

class Router {
  Router(
      {this.seller,
      this.dayRouter,
      this.secuenceRouter,
      this.client,
      this.quota,
      this.discount,
      this.price,
      this.city,
      this.groupDiscount,
      this.active,
      this.quantityClient});

  Router.fromJson(Map<String, dynamic> json) {
    seller = json['CODVENDEDOR'];
    dayRouter = json['DIARUTERO'];
    secuenceRouter = json['bank_id'];
    client = json['account_number'];
    quota = json['cupo'];
    discount = json['coddescuento'];
    price = json['CODPRECIO'];
    city = json['ciudad'];
    groupDiscount = json['codgrupodcto'];
    active = json['inactivo'];
    quantityClient = json['CANTIDADCLIENTES'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['codvendedor'] = seller;
    data['diarutero'] = dayRouter;
    data['bank_id'] = secuenceRouter;
    data['codcliente'] = client;
    data['cupo'] = quota;
    data['coddescuento'] = discount;
    data['codprecio'] = price;
    data['ciudad'] = city;
    data['codgrupodcto'] = groupDiscount;
    data['inactivo'] = active;
    data['cantidadclientes'] = quantityClient;
    return data;
  }

  String? seller;
  String? dayRouter;
  String? secuenceRouter;
  String? client;
  String? quota;
  String? discount;
  String? price;
  String? city;
  String? groupDiscount;
  String? active;
  int? quantityClient;
}
