const String tableQueries = 'queries';

class QueryFields {
  static final List<String> values = [id, table, where, arguments];

  static const String id = 'id';
  static const String table = '`table`';
  static const String where = '`where`';
  static const String arguments = 'arguments';
}

class Query {
  int? id;
  String? table;
  String? where;
  String? arguments;

  Query({this.id, this.table, this.where, this.arguments});

  factory Query.fromJson(Map<String, dynamic> json) => Query(
      id: json['id'],
      table: json['table'],
      where: json['where'],
      arguments: json['arguments']);

  Map<String, dynamic> toJson() =>
      {'id': id, 'table': table, 'where': where, 'arguments': arguments};
}
