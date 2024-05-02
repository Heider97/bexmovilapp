class Warehouse {
  String? codbodega;
  String? nombodega;
  String? ctlstockbodega;

  Warehouse({
    this.codbodega,
    this.nombodega,
    this.ctlstockbodega,
  });

  factory Warehouse.fromJson(Map<String, dynamic> json) {
    return Warehouse(
      codbodega: json['CODBODEGA'],
      nombodega: json['NOMBODEGA'],
      ctlstockbodega: json['CTLSTOCKBODEGA'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'codbodega': codbodega,
      'nombodega': nombodega,
      'ctlstockbodega': ctlstockbodega,
    };
  }
}
