class Client {
  String? nitCliente;
  String? nomCliente;
  String? dirCliente;
  String? telCliente;
  String? email;
  String? estadoCliente;

  Client({
    this.nitCliente,
    this.nomCliente,
    this.dirCliente,
    this.telCliente,
    this.email,
    this.estadoCliente,
  });

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      nitCliente: json['NITCLIENTE'],
      nomCliente: json['NOMCLIENTE'],
      dirCliente: json['DIRCLIENTE'],
      telCliente: json['TELCLIENTE'],
      email: json['EMAIL'],
      estadoCliente: json['estadocliente'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'NITCLIENTE': nitCliente,
      'NOMCLIENTE': nomCliente,
      'DIRCLIENTE': dirCliente,
      'TELCLIENTE': telCliente,
      'EMAIL': email,
      'estadocliente': estadoCliente,
    };
  }
}
