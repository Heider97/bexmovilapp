const String tableOption = 'options';

class OptionFields {
  static final List<String> values = [
    id,
    name,
    type,
    order,
    filterId,
    queryId
  ];

  static const String id = 'id';
  static const String name = 'name';
  static const String type = 'type';
  static const String order = '_order';
  static const String filterId = 'filter_id';
  static const String queryId = 'query_id';
}

class Option {
  Option({
    this.id,
    this.name,
    this.type,
    this.order,
    this.filterId,
    this.queryId,
    this.selected = false,
  });

  Option copy({
    int? id,
    String? name,
    String? type,
    int? order,
    int? filterId,
    int? queryId,
    bool? selected
  }) =>
      Option(
        id: id ?? this.id,
        name: name ?? this.name,
        type: type ?? this.type,
        order: order ?? this.order,
        filterId: filterId ?? this.filterId,
        queryId: queryId ?? this.queryId,
        selected: selected ?? this.selected,
      );

  Option.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    order = json['_order'];
    filterId = json['filter_id'];
    queryId = json['query_id'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['type'] = type;
    data['_order'] = order;
    data['filter_id'] = filterId;
    data['query_id'] = queryId;
    return data;
  }

  int? id;
  String? name;
  String? type;
  int? order;
  int? filterId;
  int? queryId;
  bool? selected;
}
