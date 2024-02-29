import 'dart:ui';

const String tableGraphics = 'graphics';

class GraphicFields {
  static final List<String> values = [
    id,
    title,
    subtitle,
    conditions,
    type,
    query,
    trigger
  ];

  static const String id = 'id';
  static const String title = 'title';
  static const String subtitle = 'subtitle';
  static const String conditions = 'conditions';
  static const String type = 'type';
  static const String query = 'query';
  static const String trigger = 'trigger';
}

class Graphic {
  int? id;
  String? title;
  String? subtitle;
  String? conditions;
  String? type;
  String? query;
  String? trigger;
  List<ChartData>? data;

  Graphic({
    this.id,
    this.title,
    this.subtitle,
    this.conditions,
    this.type,
    this.query,
    this.data,
    this.trigger
  });

  factory Graphic.fromJson(Map<String, dynamic> json) => Graphic(
      id: json['id'],
      title: json['title'],
      subtitle: json['svg'],
      conditions: json['conditions'],
      type: json['type'],
      query: json['query'],
      trigger: json['trigger'],
      data: json['results'] != null
          ? List<ChartData>.from(
              json['results'].map((r) => ChartData.fromJson(r)))
          : null);

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'subtitle': subtitle,
        'conditions': conditions,
        'type': type,
        'query': query,
        'trigger': trigger,
      };
}

class ChartData {
  ChartData(this.x, this.y, [this.color]);
  final String x;
  final double y;
  final Color? color;

  factory ChartData.fromJson(Map<String, dynamic> json) => ChartData(
        json['x'] ?? 'N/A',
        json['y'] is String
            ? double.parse(json['y'])
            : json['y'] is int
                ? json['y'].toDouble()
                : json['y'],
      );
}
