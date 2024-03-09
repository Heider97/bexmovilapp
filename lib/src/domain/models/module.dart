import 'component.dart';

const String tableModules = 'modules';

class ModuleFields {
  static final List<String> values = [id, name];

  static const String id = 'id';
  static const String name = 'name';
}

class Module {
  int? id;
  String? name;
  List<Component>? components;

  Module({
    this.id,
    this.name,
    this.components,
  });

  factory Module.fromJson(Map<String, dynamic> json) => Module(
    id: json["id"],
    name: json["name"],
    components: json["components"] == null
        ? []
        : List<Component>.from(json["components"]!.map((x) => Component.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
