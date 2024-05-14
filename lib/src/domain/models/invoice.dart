class Invoice {
  int? codcliente;
  int? nummov;
  String? fecven;
  String? state;
  int? preciomov;

  Invoice({
    this.codcliente,
    this.nummov,
    this.fecven,
    this.state,
    this.preciomov,
  });

  factory Invoice.fromJson(Map<String, dynamic> json) {
    return Invoice(
      codcliente: json['codcliente'],
      nummov: json['nummov'],
      fecven: json['fecven'],
      state: json['state'],
      preciomov: json['preciomov'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'codcliente': codcliente,
      'fecven': fecven,
      'nummov': nummov,
      'state' : state,
      'preciomov': preciomov,
    };
  }
}
