class Priority {
  int id;
  String name;
  int priority;
  int runBackground;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? schema;
  int version;

  Priority({
    required this.id,
    required this.name,
    required this.priority,
    required this.runBackground,
    required this.createdAt,
    required this.updatedAt,
    this.schema,
    required this.version,
  });

  factory Priority.fromJson(Map<String, dynamic> json) => Priority(
        id: json["id"],
        name: json["name"],
        priority: json["priority"],
        runBackground: json["run_background"],
        createdAt: json["created_at"] != null
            ? DateTime.parse(json["created_at"])
            : null,
        updatedAt: json["updated_at"] != null
            ? DateTime.parse(json["updated_at"])
            : null,
        schema: json["schema"],
        version: json["version"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "priority": priority,
        "run_background": runBackground,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "schema": schema,
        "version": version,
      };
}
