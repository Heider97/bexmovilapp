const String tableModules = 'app_modules';

class ModuleFields {
  static final List<String> values = [id, name];

  static const String id = 'id';
  static const String name = 'name';
  static const String route = 'route';
  static const String type = 'type';
  static const String arguments = 'arguments';
}

class Module {
  int? id;
  String? name;
  String? route;
  String? type;
  String? arguments;

  Module({
    this.id,
    this.name,
    this.route,
    this.type,
    this.arguments,
  });

  factory Module.fromJson(Map<String, dynamic> json) => Module(
        id: json["id"],
        name: json["name"],
        route: json["route"],
        type: json["type"],
        arguments: json["arguments"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "route": route,
        "type": type,
        "arguments": arguments,
      };
}
