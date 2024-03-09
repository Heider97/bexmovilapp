const String tableQueries = 'queries';

class QueryFields {
  static final List<String> values = [id, name, type, where, arguments];

  static const String id = 'id';
  static const String name = 'name';
  static const String type = 'type';
  static const String where = 'where';
  static const String arguments = 'arguments';
  static const String logicId = 'logic_id';
  static const String componentId = 'component_id';
  static const String tableName = 'table_name';
  static const String tableId = 'table_id';
}

class Query {
  int? id;
  String? name;
  String? type;
  String? where;
  String? arguments;
  int? logicId;
  int? componentId;
  String? tableName;
  int? tableId;

  Query({
    this.id,
    this.name,
    this.type,
    this.where,
    this.arguments,
    this.logicId,
    this.componentId,
    this.tableName,
    this.tableId,
  });

  factory Query.fromJson(Map<String, dynamic> json) => Query(
        id: json['id'],
        name: json['name'],
        type: json['type'],
        where: json['where'],
        arguments: json['arguments'],
        logicId: json['logic_id'],
        componentId: json['component_id'],
        tableName: json['table_name'],
        tableId: json['table_id'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'type': type,
        'where': where,
        'arguments': arguments,
        'logic_id': logicId,
        'component_id': componentId,
        'table_name': tableName,
        'arguments': tableId,
      };
}
