import 'query.dart';

const String tableComponents = 'components';

class ComponentFields {
  static final List<String> values = [id, name, moduleId];

  static const String id = 'id';
  static const String name = 'name';
  static const String moduleId = 'module_id';
}

class Component {
  int? id;
  String? name;
  int? moduleId;
  List<Query>? queries;

  Component({
    this.id,
    this.name,
    this.moduleId,
    this.queries,
  });

  factory Component.fromJson(Map<String, dynamic> json) => Component(
    id: json["id"],
    name: json["name"],
    moduleId: json["module_id"],
    queries: json["queries"] == null
        ? []
        : List<Query>.from(json["queries"]!.map((x) => Query.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "module_id": moduleId,
  };
}
