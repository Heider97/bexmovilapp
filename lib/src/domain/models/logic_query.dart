const String tableLogicsQueries = 'app_logics_queries';

class LogicQueryFields {
  static final List<String> values = [
    id,
    queryId,
    queryType,
    logicId,
  ];

  static const String id = 'id';
  static const String queryId = 'query_id';
  static const String queryType = 'query_type';
  static const String logicId = 'logic_id';
  static const String componentId = 'component_id';
}

class LogicQuery {
  LogicQuery(
      {this.id, this.queryId, this.queryType, this.logicId, this.componentId});

  LogicQuery copy({
    int? id,
    int? queryId,
    String? queryType,
    int? logicId,
    int? componentId,
  }) =>
      LogicQuery(
        id: id ?? this.id,
        queryId: queryId ?? this.queryId,
        queryType: queryType ?? this.queryType,
        logicId: logicId ?? this.logicId,
        componentId: componentId ?? this.componentId,
      );

  LogicQuery.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    queryId = json['query_id'];
    queryType = json['query_type'];
    logicId = json['logic_id'];
    componentId = json['component_id'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['query_id'] = queryId;
    data['query_type'] = queryType;
    data['logic_id'] = logicId;
    data['component_id'] = componentId;
    return data;
  }

  int? id;
  int? queryId;
  String? queryType;
  int? logicId;
  int? componentId;
}
