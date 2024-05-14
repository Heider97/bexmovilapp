import 'dart:convert';
import '../kpi.dart';

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
