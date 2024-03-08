const String tableQueries = 'queries';

class QueryFields {
  static final List<String> values = [id, name, type, where, arguments];

  static const String id = 'id';
  static const String name = 'name';
  static const String type = 'type';
  static const String where = 'where';
  static const String arguments = 'arguments';
}

class Query {
  int? id;
  String? name;
  String? type;
  String? where;
  String? arguments;

  Query({
    this.id,
    this.name,
    this.type,
    this.where,
    this.arguments,
  });

  factory Query.fromJson(Map<String, dynamic> json) => Query(
      id: json["id"],
      name: json["name"],
      type: json["type"],
      where: json["where"],
      arguments: json["arguments"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type,
        "where": where,
        "arguments": arguments
      };
}
