import 'widget.dart';

const String tableSections = 'app_sections';

class SectionFields {
  static final List<String> values = [id, name, type];

  static const String id = 'id';
  static const String name = 'name';
  static const String type = 'type';
}

class Section {
  int? id;
  String? name;
  String? type;
  List<Widget>? widgets;

  Section({
    this.id,
    this.name,
    this.type,
    this.widgets
  });

  factory Section.fromJson(Map<String, dynamic> json) => Section(
    id: json["id"],
    name: json["name"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "type": type,
  };
}
