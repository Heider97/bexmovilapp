const String tableComponents = 'app_components';

class ComponentFields {
  static final List<String> values = [
    id,
    type,
    widgetId
  ];

  static const String id = 'id';
  static const String type = 'type';
  static const String widgetId = 'widget_id';
}

class Component {
  int? id;
  String? type;
  int? widgetId;
  dynamic results;

  Component({
    this.id,
    this.type,
    this.widgetId,
    this.results
  });

  factory Component.fromJson(Map<String, dynamic> json) => Component(
    id: json['id'],
    type: json['type'],
    widgetId: json['widget_id'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'type': type,
    'widget_id': widgetId,
  };
}
