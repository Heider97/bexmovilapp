const String tableLogicsQueries = 'app_logicables';

class LogicQueryFields {
  static final List<String> values = [
    id,
    actionableId,
    actionableType,
    logicId,
  ];

  static const String id = 'id';
  static const String actionableId = 'actionable_id';
  static const String actionableType = 'actionable_type';
  static const String logicId = 'logic_id';
  static const String componentId = 'component_id';
}

class LogicQuery {
  LogicQuery(
      {this.id, this.actionableId, this.actionableType, this.logicId, this.componentId});

  LogicQuery copy({
    int? id,
    int? actionableId,
    String? actionableType,
    int? logicId,
    int? componentId,
  }) =>
      LogicQuery(
        id: id ?? this.id,
        actionableId: actionableId ?? this.actionableId,
        actionableType: actionableType ?? this.actionableType,
        logicId: logicId ?? this.logicId,
        componentId: componentId ?? this.componentId,
      );

  LogicQuery.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    actionableId = json['actionable_id'];
    actionableType = json['actionable_type'];
    logicId = json['logic_id'];
    componentId = json['component_id'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['actionable_id'] = actionableId;
    data['actionable_type'] = actionableType;
    data['logic_id'] = logicId;
    data['component_id'] = componentId;
    return data;
  }

  int? id;
  int? actionableId;
  String? actionableType;
  int? logicId;
  int? componentId;
}
