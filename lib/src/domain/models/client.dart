const String tableClient = 'tblmcliente';
class Client {
  String? name;
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

  DateTime? startTimeOfMeeting;
  DateTime? endTimeOfMeeting;
  DateTime? lastVisited;
  String? averageSales;
  String? salesEffectiveness;

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
    this.name,
    this.startTimeOfMeeting,
    this.endTimeOfMeeting,
    this.averageSales,
    this.salesEffectiveness,
    this.lastVisited,
  });

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
        nitCliente: json['NITCLIENTE'],
        nomCliente: json['NOMCLIENTE'],
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
        name: json['name'],
        startTimeOfMeeting: json['startTimeOfMeeting'],
        endTimeOfMeeting: json['endTimeOfMeeting'],
        averageSales: json['averageSales'],
        salesEffectiveness: json['salesEffectiveness'],
        lastVisited: json['lastVisited']);
  }

  Map<String, dynamic> toJson() {
    return {
      'NITCLIENTE': nitCliente,
      'NOMCLIENTE': nomCliente,
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
