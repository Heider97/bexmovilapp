const String tableRawQueries = 'raw_queries';

class RawQueryFields {
  static final List<String> values = [id, name, where, arguments, replaceAll];

  static const String id = 'id';
  static const String name = 'name';
  static const String where = '`where`';
  static const String arguments = 'arguments';
  static const String replaceAll = 'replace_all';
}

class RawQuery {
  int? id;
  String? name;
  String? where;
  String? arguments;
  bool? replaceAll;

  RawQuery({
    this.id,
    this.name,
    this.where,
    this.arguments,
    this.replaceAll
  });

  factory RawQuery.fromJson(Map<String, dynamic> json) => RawQuery(
    id: json['id'],
    name: json['name'],
    where: json['where'],
    arguments: json['arguments'],
    replaceAll: json['replace_all']
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'where': where,
    'arguments': arguments,
    'replace_all': replaceAll
  };
}
