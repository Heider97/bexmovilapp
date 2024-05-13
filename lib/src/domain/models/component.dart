const String tableComponents = 'app_components';

class ComponentFields {
  static final List<String> values = [
    id,
    title,
    subtitle,
    type,
    line,
    interactive,
    trigger,
    logicQueryId,
    widgetId
  ];

  static const String id = 'id';
  static const String title = 'title';
  static const String subtitle = 'subtitle';
  static const String type = 'type';
  static const String line = 'line';
  static const String interactive = 'interactive';
  static const String trigger = 'trigger';
  static const String logicQueryId = 'logic_query_id';
  static const String widgetId = 'widget_id';
}

class Component {
  int? id;
  String? title;
  String? subtitle;
  String? type;
  int? line;
  int? interactive;
  String? trigger;
  int? logicQueryId;
  int? widgetId;
  dynamic results;

  Component({
    this.id,
    this.title,
    this.subtitle,
    this.type,
    this.line,
    this.interactive,
    this.trigger,
    this.logicQueryId,
    this.widgetId,
    this.results
  });

  factory Component.fromJson(Map<String, dynamic> json) => Component(
    id: json['id'],
    title: json['title'],
    subtitle: json['subtitle'],
    type: json['type'],
    line: json['line'],
    interactive: json['interactive'],
    trigger: json['trigger'],
    logicQueryId: json['logicQueryId'],
    widgetId: json['widget_id'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'subtitle': subtitle,
    'type': type,
    'line': line,
    'interactive': interactive,
    'trigger': trigger,
    'logic_query_id': logicQueryId,
    'widget_id': widgetId,
  };
}
