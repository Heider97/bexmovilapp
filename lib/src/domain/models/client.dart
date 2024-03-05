class Client {
  String? name;
  String? email;
  String? dirCliente;
  String? telCliente;
<<<<<<< HEAD
  String? sucursalCliente;
  String? codeCliente;
  String? precioCliente;
  int? cupoCliente;
  String? formaPagoCliente;

  bool? isBooked;
  String? nitCliente;
  String? nomCliente;
  String? razCliente;
=======

  bool? isBooked;
  String? nitCliente;
>>>>>>> f6c1904317fe26e741192873d670bfef5c677496
  String? estadoCliente;

  String? docType;
  String? expireDate;
  String? movDate;

  DateTime? startTimeOfMeeting;
  DateTime? endTimeOfMeeting;
  DateTime? lastVisited;
  String? averageSales;
  String? salesEffectiveness;
  int? overdueInvoices;
  int? walletAmmount;

<<<<<<< HEAD
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
=======
  Client(
      {this.isBooked,
      this.nitCliente,
      this.dirCliente,
      this.telCliente,
      this.email,
      this.estadoCliente,
      this.name,
      this.startTimeOfMeeting,
      this.endTimeOfMeeting,
      this.averageSales,
      this.salesEffectiveness,
      this.lastVisited,
      this.docType,
      this.expireDate,
      this.movDate,
      this.overdueInvoices,
      this.walletAmmount});
>>>>>>> f6c1904317fe26e741192873d670bfef5c677496

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
        nitCliente: json['NITCLIENTE'],
        dirCliente: json['DIRCLIENTE'],
        telCliente: json['TELCLIENTE'],
<<<<<<< HEAD
        razCliente: json['RAZCLIENTE'],
        codeCliente: json['CODCLIENTE'],
        cupoCliente: json['CUPO'],
        formaPagoCliente: json['CODFPAGOVTA'],
        precioCliente: json['CODPRECIO'],
        sucursalCliente: json['SUCCLIENTE'],
=======
>>>>>>> f6c1904317fe26e741192873d670bfef5c677496
        email: json['EMAIL'],
        estadoCliente: json['estadocliente'],
        name: json['name'],
        startTimeOfMeeting: json['startTimeOfMeeting'],
        endTimeOfMeeting: json['endTimeOfMeeting'],
        averageSales: json['averageSales'],
        salesEffectiveness: json['salesEffectiveness'],
        lastVisited: json['lastVisited'],
        docType: json['docType'],
        expireDate: json['expireDate'],
        movDate: json['movDate'],
        overdueInvoices: json['overdueInvoices'],
        walletAmmount: json['walletAmmount']);
  }

  Map<String, dynamic> toJson() {
    return {
      'NITCLIENTE': nitCliente,
      'DIRCLIENTE': dirCliente,
      'RAZCLIENTE': razCliente,
      'TELCLIENTE': telCliente,
<<<<<<< HEAD
      'CODCLIENTE': codeCliente,
      'CUPO': cupoCliente,
      'CODPRECIO': precioCliente,
      'CODFPAGOVTA': formaPagoCliente,
      'SUCCLIENTE': sucursalCliente,
=======
>>>>>>> f6c1904317fe26e741192873d670bfef5c677496
      'EMAIL': email,
      'estadocliente': estadoCliente,
    };
  }
}
