import 'component.dart';

const String tableSections = 'app_sections';

class SectionFields {
  static final List<String> values = [id, name];

  static const String id = 'id';
  static const String name = 'name';
}

class Section {
  int? id;
  String? name;
  List<Component>? components;

  Section({
    this.id,
    this.name,
    this.components
  });

  factory Section.fromJson(Map<String, dynamic> json) => Section(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
