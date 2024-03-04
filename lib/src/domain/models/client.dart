const String tableClient = 'tblmcliente';
class Client {
  String? name;
  String? email;
  String? dirCliente;
  String? telCliente;
  String? sucursalCliente;
  String? codeCliente;

  bool? isBooked;
  String? nitCliente;
  String? nomCliente;
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
    this.dirCliente,
    this.telCliente,
    this.codeCliente,
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
        codeCliente: json['CODCLIENTE'],
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
      'TELCLIENTE': telCliente,
      'CODCLIENTE': codeCliente,
      'SUCCLIENTE': sucursalCliente,
      'EMAIL': email,
      'estadocliente': estadoCliente,
    };
  }
}
