const String tableLogics = 'app_logics';

class LogicFields {
  static final List<String> values = [
    id,
    table,
    column,
    condition,
  ];

  static const String id = 'id';
  static const String table = '`table`';
  static const String column = 'column';
  static const String condition = 'condition';
}

class Logic {
  Logic({this.id, this.table, this.condition, this.column});

  Logic copy({
    int? id,
    String? table,
    String? condition,
    String? column,
  }) =>
      Logic(
        id: id ?? this.id,
        table: table ?? this.table,
        condition: condition ?? this.condition,
        column: column ?? this.column,
      );

  Logic.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    table = json['table'];
    condition = json['condition'];
    column = json['column'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['table'] = table;
    data['condition'] = condition;
    data['column'] = column;
    return data;
  }

  int? id;
  String? table;
  String? condition;
  String? column;
}
