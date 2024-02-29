import 'dart:ui';

const String tableGraphics = 'graphics';

class GraphicFields {
  static final List<String> values = [
    id,
    title,
    subtitle,
    conditions,
    type,
    query
  ];

  static const String id = 'id';
  static const String title = 'title';
  static const String subtitle = 'subtitle';
  static const String conditions = 'values';
  static const String type = 'type';
  static const String query = 'query';
}

class Graphic {
  int? id;
  String? title;
  String? subtitle;
  String? conditions;
  String? type;
  String? query;
  List<ChartData>? data;

  Graphic({
    this.id,
    this.title,
    this.subtitle,
    this.conditions,
    this.type,
    this.query,
    this.data,
  });

  factory Graphic.fromJson(Map<String, dynamic> json) => Graphic(
      id: json['id'],
      title: json['title'],
      subtitle: json['svg'],
      conditions: json['conditions'],
      type: json['type'],
      query: json['query'],
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
