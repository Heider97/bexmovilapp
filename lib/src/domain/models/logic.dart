const String tableLogics = 'logics';

class LogicFields {
  static final List<String> values = [
    id,
    table,
    condition,
    result,
  ];

  static const String id = 'id';
  static const String table = '`table`';
  static const String condition = 'condition';
  static const String result = 'result';
}

class Logic {
  Logic({this.id, this.table, this.condition, this.result});

  Logic copy({
    int? id,
    String? table,
    String? condition,
    String? result,
  }) =>
      Logic(
        id: id ?? this.id,
        table: table ?? this.table,
        condition: condition ?? this.condition,
        result: result ?? this.result,
      );

  Logic.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    table = json['table'];
    condition = json['condition'];
    result = json['result'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['table'] = table;
    data['condition'] = condition;
    data['result'] = result;
    return data;
  }

  int? id;
  String? table;
  String? condition;
  String? result;
}
