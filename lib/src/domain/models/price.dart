class Price {
  String? codprecio;
  String? nomprecio;

  Price({
    this.codprecio,
    this.nomprecio,
  });

  factory Price.fromJson(Map<String, dynamic> json) {
    return Price(
      codprecio: json['codprecio'],
      nomprecio: json['nomprecio'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'codprecio': codprecio,
      'nomprecio': nomprecio,
    };
  }
}
