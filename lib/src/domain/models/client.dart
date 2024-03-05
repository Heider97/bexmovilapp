class Client {
  String? name;
  String? email;
  String? dirCliente;
  String? telCliente;

  bool? isBooked;
  String? nitCliente;
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

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
        nitCliente: json['NITCLIENTE'],
        dirCliente: json['DIRCLIENTE'],
        telCliente: json['TELCLIENTE'],
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
      'TELCLIENTE': telCliente,
      'EMAIL': email,
      'estadocliente': estadoCliente,
    };
  }
}
