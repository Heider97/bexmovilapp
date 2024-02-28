import 'dart:convert';

KpiResponse kpiResponseFromJson(String str) =>
    KpiResponse.fromJson(json.decode(str));

String kpiResponseToJson(KpiResponse data) => json.encode(data.toJson());

class KpiResponse {
  bool? status;
  String? message;
  List<Kpi>? kpis;

  KpiResponse({
    this.status,
    this.message,
    this.kpis,
  });

  factory KpiResponse.fromJson(Map<String, dynamic> json) => KpiResponse(
        status: json["status"],
        message: json["message"],
        kpis: json["kpis"] == null
            ? []
            : List<Kpi>.from(json["kpis"]!.map((x) => Kpi.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "kpis": kpis == null
            ? []
            : List<dynamic>.from(kpis!.map((x) => x.toJson())),
      };
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
