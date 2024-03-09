import 'dart:convert';
import '../module.dart';

ModuleResponse kpiResponseFromJson(String str) =>
    ModuleResponse.fromJson(json.decode(str));

String kpiResponseToJson(ModuleResponse data) => json.encode(data.toJson());

class ModuleResponse {
  bool? status;
  String? message;
  List<Module>? modules;

  ModuleResponse({
    this.status,
    this.message,
    this.modules,
  });

  factory ModuleResponse.fromJson(Map<String, dynamic> json) => ModuleResponse(
    status: json["status"],
    message: json["message"],
    modules: json["modules"] == null
        ? []
        : List<Module>.from(json["modules"]!.map((x) => Module.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "modules": modules == null
        ? []
        : List<dynamic>.from(modules!.map((x) => x.toJson())),
  };
}
