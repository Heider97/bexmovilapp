import 'dart:convert';
import '../filter.dart';

FilterResponse functionalityResponseFromJson(String str) =>
    FilterResponse.fromJson(json.decode(str));

String functionalityResponseToJson(FilterResponse data) =>
    json.encode(data.toJson());

class FilterResponse {
  bool? status;
  String? message;
  List<Filter>? filters;

  FilterResponse({
    this.status,
    this.message,
    this.filters,
  });

  factory FilterResponse.fromJson(Map<String, dynamic> json) =>
      FilterResponse(
        status: json["status"],
        message: json["message"],
        filters: json["filters"] == null
            ? []
            : List<Filter>.from(
            json["filters"]!.map((x) => Filter.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "filters": filters == null
        ? []
        : List<dynamic>.from(filters!.map((x) => x.toJson())),
  };
}
