const String tableBlocEvents = 'app_bloc_events';

class BlocEventFields {
  static final List<String> values = [
    id,
    name,
    type,
    arguments,
    appBlocId,
    createdAt
  ];

  static const String id = 'id';
  static const String name = 'name';
  static const String type = 'type';
  static const String arguments = 'arguments';
  static const String appBlocId = 'app_bloc_id';
  static const String createdAt = 'createdAt';
}

class BlocEvent {
  int? id;
  String? name;
  String? type;
  int? appBlocId;
  String? arguments;
  String? createdAt;

  BlocEvent({
    this.id,
    this.name,
    this.type,
    this.appBlocId,
    this.createdAt,
    this.arguments,
  });

  factory BlocEvent.fromJson(Map<String, dynamic> json) => BlocEvent(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      createdAt: json['created_at'],
      arguments: json['arguments'],
      appBlocId: json['app_bloc_id']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'type': type,
        'created_at': createdAt,
        'arguments': arguments,
        'app_bloc_id': appBlocId
      };
}
