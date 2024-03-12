const String tableModules = 'modules';

class ModuleFields {
  static final List<String> values = [id, name];

  static const String id = 'id';
  static const String name = 'name';
}

class Module {
  int? id;
  String? name;

  Module({
    this.id,
    this.name,
  });

  factory Module.fromJson(Map<String, dynamic> json) => Module(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
