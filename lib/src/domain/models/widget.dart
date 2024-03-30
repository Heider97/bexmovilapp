const String tableWidgets = 'app_names';

class WidgetFields {
  static final List<String> values = [id, name, type];

  static const String id = 'id';
  static const String name = 'name';
  static const String type = 'type';
  static const String sectionId = 'section_id';
}

class Widget {
  int? id;
  String? name;
  String? type;
  String? sectionId;

  Widget({
    this.id,
    this.name,
    this.type,
    this.sectionId,
  });

  factory Widget.fromJson(Map<String, dynamic> json) => Widget(
    id: json["id"],
    name: json["name"],
    type: json["type"],
    sectionId: json["section_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "type": type,
    "section_id": sectionId,
  };
}
