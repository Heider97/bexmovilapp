const String tableKpis = 'kpis';

class KpiFields {
  static final List<String> values = [id, title, type, value];

  static const String id = 'id';
  static const String title = 'title';
  static const String line = 'line';
  static const String type = 'type';
  static const String value = 'value';
}

class Kpi {
  int? id;
  String? title;
  String? type;
  int? line;
  String? value;

  Kpi({
    this.id,
    this.title,
    this.type,
    this.line,
    this.value,
  });

  factory Kpi.fromJson(Map<String, dynamic> json) => Kpi(
    id: json["id"],
    title: json["title"],
    type: json["type"],
    line: json["line"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "type": type,
    "line": line,
    "value": value,
  };
}
