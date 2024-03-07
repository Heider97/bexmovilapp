class Invoice {
  String? code;
  String? numMov;
  String? expirationDate;
  String? value;
  Invoice({this.code, this.numMov, this.expirationDate, this.value});

  factory Invoice.fromJson(Map<String, dynamic> json) {
    return Invoice(
      code: json['code'],
      numMov: json['numMov'],
      expirationDate: json['expirationDate'],
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['numMov'] = this.numMov;
    data['expirationDate'] = this.expirationDate;
    data['value'] = this.value;
    return data;
  }
}
