import 'option.dart';

const String tableFilters = 'filters';

class FilterFields {
  static final List<String> values = [
    id,
    name,
    module,
    type,
  ];

  static const String id = 'id';
  static const String name = 'name';
  static const String module = 'module';
  static const String type = 'type';
}

class Filter {
  Filter({this.id, this.name, this.module, this.type, this.options});

  Filter copy({
    int? id,
    String? name,
    String? module,
    String? type,
    List<Option>? options,
  }) =>
      Filter(
        id: id ?? this.id,
        name: name ?? this.name,
        module: module ?? this.module,
        type: type ?? this.type,
        options: options ?? this.options,
      );

  Filter.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    module = json['module'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['module'] = module;
    data['type'] = type;
    return data;
  }

  int? id;
  String? name;
  String? module;
  String? type;
  bool? enabled;
  List<Option>? options;
}
