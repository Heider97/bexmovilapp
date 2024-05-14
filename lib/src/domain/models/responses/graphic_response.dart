import 'dart:convert';
import '../graphic.dart';

GraphicResponse functionalityResponseFromJson(String str) =>
    GraphicResponse.fromJson(json.decode(str));

String functionalityResponseToJson(GraphicResponse data) =>
    json.encode(data.toJson());

class GraphicResponse {
  bool? status;
  String? message;
  List<Graphic>? graphics;

  GraphicResponse({
    this.status,
    this.message,
    this.graphics,
  });

  factory GraphicResponse.fromJson(Map<String, dynamic> json) =>
      GraphicResponse(
        status: json["status"],
        message: json["message"],
        graphics: json["graphics"] == null
            ? []
            : List<Graphic>.from(
                json["graphics"]!.map((x) => Graphic.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "graphics": graphics == null
            ? []
            : List<dynamic>.from(graphics!.map((x) => x.toJson())),
      };
}
