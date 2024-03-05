const String tableKpis = 'kpis';

class KpiFields {
  static final List<String> values = [id, title, sql, type, value];

  static const String id = 'id';
  static const String title = 'title';
  static const String line = 'line';
  static const String sql = 'sql';
  static const String type = 'type';
  static const String value = 'value';
}

class Kpi {
  int? id;
  String? title;
  String? sql;
  String? type;
  int? line;
  String? value;

  Kpi({
    this.id,
    this.title,
    this.sql,
    this.type,
    this.line,
    this.value,
  });

  factory Kpi.fromJson(Map<String, dynamic> json) => Kpi(
    id: json["id"],
    title: json["title"],
    sql: json["sql"],
    type: json["type"],
    line: json["line"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "sql": sql,
    "type": type,
    "line": line,
    "value": value,
  };
}
