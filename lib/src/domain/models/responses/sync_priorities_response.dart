// To parse this JSON data, do
//
//     final updateUserResponse = updateUserResponseFromJson(jsonString);

import 'dart:convert';

import 'package:bexmovil/src/domain/models/priority.dart';

SyncPrioritiesResponse updateUserResponseFromJson(String str) =>
    SyncPrioritiesResponse.fromJson(json.decode(str));

String updateUserResponseToJson(SyncPrioritiesResponse data) =>
    json.encode(data.toJson());

class SyncPrioritiesResponse {
  bool status;
  String message;
  int version;
  List<Priority>? priorities;

  SyncPrioritiesResponse({
    required this.status,
    required this.message,
    required this.version,
    this.priorities,
  });

  factory SyncPrioritiesResponse.fromJson(Map<String, dynamic> json) =>
      SyncPrioritiesResponse(
        status: json["status"],
        message: json["message"],
        version: json["version"],
        priorities: json["priorities"] != null
            ? List<Priority>.from(
                json["priorities"].map((x) => Priority.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "version": version,
        "priorities": List<dynamic>.from(priorities!.map((x) => x.toJson())),
      };
}
