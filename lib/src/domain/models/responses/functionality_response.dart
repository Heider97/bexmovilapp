import 'dart:convert';
import '../application.dart';

FunctionalityResponse functionalityResponseFromJson(String str) =>
    FunctionalityResponse.fromJson(json.decode(str));

String functionalityResponseToJson(FunctionalityResponse data) =>
    json.encode(data.toJson());

class FunctionalityResponse {
  bool? status;
  String? message;
  List<Application>? functionalities;

  FunctionalityResponse({
    this.status,
    this.message,
    this.functionalities,
  });

  factory FunctionalityResponse.fromJson(Map<String, dynamic> json) =>
      FunctionalityResponse(
        status: json["status"],
        message: json["message"],
        functionalities: json["functionalities"] == null
            ? []
            : List<Application>.from(
                json["functionalities"]!.map((x) => Application.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "functionalities": functionalities == null
            ? []
            : List<dynamic>.from(functionalities!.map((x) => x.toJson())),
      };
}
