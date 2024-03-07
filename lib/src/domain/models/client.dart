class Client {
  String? email;
  String? dirCliente;
  String? telCliente;
  String? sucursalCliente;
  int? codeCliente;
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

  Client(
      {this.isBooked,
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
      this.hasCompleted = 0});

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
        nitCliente: json['nitcliente'],
        dirCliente: json['dircliente'],
        telCliente: json['telcliente'],
        razCliente: json['razcliente'],
        codeCliente: json['codcliente'],
        cupoCliente: json['cupo'],
        formaPagoCliente: json['codfpagovta'],
        precioCliente: json['codprecio'],
        sucursalCliente: json['succliente'],
        email: json['email'],
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
        total: json['total'],
        wallet: json['wallet'],
        latitude: json['latitud'],
        longitude: json['longitud']);
  }

  Map<String, dynamic> toJson() {
    return {
      'nitcliente': nitCliente,
      'nomcliente': nomCliente,
      'direcliente': dirCliente,
      'razcliente': razCliente,
      'telcliente': telCliente,
      'codcliente': codeCliente,
      'cupo': cupoCliente,
      'codprecio': precioCliente,
      'codfpagovta': formaPagoCliente,
      'succliente': sucursalCliente,
      'email': email,
      'estadocliente': estadoCliente,
    };
  }
}
