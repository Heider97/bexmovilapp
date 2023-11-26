import 'package:equatable/equatable.dart';

const String tableConfig = 'configs';

class ConfigFields{
  static final List<String> values = [
    id,
    name,
    type,
    value,
    module
  ];

  static const String id = 'id';
  static const String name = 'name';
  static const String type = 'type';
  static const String value = 'value';
  static const String module = 'module';
}

class Config extends Equatable {
  final int? id;
  final String? name;
  final String? type;
  final String? value;
  final String? module;

  const Config({this.id, this.name, this.type, this.value, this.module});

  factory Config.fromMap(Map<String, dynamic> map) {
    return Config(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
      value: map['value'] != null ? map['value'] as String : null,
      module: map['module'] != null ? map['require_arrived'] as String : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'value': value,
      'module': module,
    };
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [id, name, type, value, module];
}
