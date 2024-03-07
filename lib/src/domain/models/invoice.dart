class Invoice {
  String? codcliente;
  String? nummov;
  String? fecven;
  String? preciomov;

  Invoice({
    this.codcliente,
    this.nummov,
    this.fecven,
    this.preciomov,
  });

  factory Invoice.fromJson(Map<String, dynamic> json) {
    return Invoice(
      codcliente: json['codcliente'],
      nummov: json['nummov'],
      fecven: json['fecven'],
      preciomov: json['preciomov'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'codcliente': codcliente,
      'fecven': fecven,
      'nummov': nummov,
      'preciomov': preciomov,
    };
  }
}
