const String tableQueries = 'queries';

class QueryFields {
  static final List<String> values = [id, name, type, where, arguments];

  static const String id = 'id';
  static const String name = 'name';
  static const String type = 'type';
  static const String where = '`where`';
  static const String arguments = 'arguments';
  static const String componentId = 'component_id';
  static const String tableName = 'table_name';
  static const String tableId = 'table_id';
  static const String replaceAll = 'replace_all';
  static const String deepResults = 'deep_results';
}

class Query {
  int? id;
  String? name;
  String? type;
  String? where;
  String? arguments;
  int? componentId;
  String? tableName;
  int? tableId;
  bool? replaceAll;
  bool? deepResults;

  Query({
    this.id,
    this.name,
    this.type,
    this.where,
    this.arguments,
    this.componentId,
    this.tableName,
    this.tableId,
    this.replaceAll,
    this.deepResults
  });

  factory Query.fromJson(Map<String, dynamic> json) => Query(
        id: json['id'],
        name: json['name'],
        type: json['type'],
        where: json['where'],
        arguments: json['arguments'],
        componentId: json['component_id'],
        tableName: json['table_name'],
        tableId: json['table_id'],
        replaceAll: json['replace_all'],
        deepResults: json['deep_results'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'type': type,
        'where': where,
        'arguments': arguments,
        'component_id': componentId,
        'table_name': tableName,
        'replace_all': replaceAll,
        'deep_results': deepResults
      };
}
