class Warehouse {
  int consecutivo;
  String codVendedor;
  String codBodega;
  DateTime fecha;
  String codGra;

  Warehouse({
    required this.consecutivo,
    required this.codVendedor,
    required this.codBodega,
    required this.fecha,
    required this.codGra,
  });

  factory Warehouse.fromJson(Map<String, dynamic> json) => Warehouse(
        consecutivo: json['consecutivo'],
        codVendedor: json['codVendedor'],
        codBodega: json['codBodega'],
        fecha: DateTime.parse(json['fecha']),
        codGra: json['codGra'],
      );

  Map<String, dynamic> toJson() => {
        'consecutivo': consecutivo,
        'codVendedor': codVendedor,
        'codBodega': codBodega,
        'fecha': fecha.toIso8601String(),
        'codGra': codGra,
      };
}
