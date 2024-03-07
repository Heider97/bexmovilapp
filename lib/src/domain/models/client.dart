class Client {
  String? email;
  String? dirCliente;
  String? telCliente;
  String? sucursalCliente;
  String? codeCliente;
  String? precioCliente;
  int? cupoCliente;
  String? formaPagoCliente;

  bool? isBooked;
  String? nitCliente;
  String? nomCliente;
  String? razCliente;
  String? estadoCliente;

  String? docType;
  String? expireDate;
  String? movDate;

  String? latitude;
  String? longitude;
  String? distance;
  String? duration;
  int? color;

  int? hasCompleted;

  DateTime? startTimeOfMeeting;
  DateTime? endTimeOfMeeting;
  DateTime? lastVisited;
  String? averageSales;
  String? salesEffectiveness;
  int? total;
  int? wallet;

  Client({
    this.isBooked,
    this.nitCliente,
    this.nomCliente,
    this.razCliente,
    this.dirCliente,
    this.telCliente,
    this.codeCliente,
    this.cupoCliente,
    this.precioCliente,
    this.formaPagoCliente,
    this.sucursalCliente,
    this.email,
    this.estadoCliente,
    this.startTimeOfMeeting,
    this.endTimeOfMeeting,
    this.averageSales,
    this.salesEffectiveness,
    this.lastVisited,
    this.docType,
    this.expireDate,
    this.movDate,
    this.total,
    this.wallet,
    this.latitude,
    this.longitude,
    this.distance,
    this.duration,
    this.color,
    this.hasCompleted = 0
  });

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
        nitCliente: json['NITCLIENTE'],
        dirCliente: json['DIRCLIENTE'],
        telCliente: json['TELCLIENTE'],
        razCliente: json['RAZCLIENTE'],
        codeCliente: json['CODCLIENTE'],
        cupoCliente: json['CUPO'],
        formaPagoCliente: json['CODFPAGOVTA'],
        precioCliente: json['CODPRECIO'],
        sucursalCliente: json['SUCCLIENTE'],
        email: json['EMAIL'],
        estadoCliente: json['estadocliente'],
        nomCliente: json['nomcliente'],
        startTimeOfMeeting: json['startTimeOfMeeting'],
        endTimeOfMeeting: json['endTimeOfMeeting'],
        averageSales: json['averageSales'],
        salesEffectiveness: json['salesEffectiveness'],
        lastVisited: json['lastVisited'],
        docType: json['docType'],
        expireDate: json['expireDate'],
        movDate: json['movDate'],
        total: json['overdueInvoices'],
        wallet: json['walletAmmount'],
        latitude: json['latitud'],
        longitude: json['longitud']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'NITCLIENTE': nitCliente,
      'NOMCLIENTE' : nomCliente,
      'DIRCLIENTE': dirCliente,
      'RAZCLIENTE': razCliente,
      'TELCLIENTE': telCliente,
      'CODCLIENTE': codeCliente,
      'CUPO': cupoCliente,
      'CODPRECIO': precioCliente,
      'CODFPAGOVTA': formaPagoCliente,
      'SUCCLIENTE': sucursalCliente,
      'EMAIL': email,
      'estadocliente': estadoCliente,
    };
  }
}
