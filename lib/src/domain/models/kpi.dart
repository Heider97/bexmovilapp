const String tableKpis = 'kpis';

class KpiFields {
  static final List<String> values = [
    id,
    title,
    subtitle,
    type,
    line,
  ];

  static const String id = 'id';
  static const String title = 'title';
  static const String subtitle = 'subtitle';
  static const String type = 'type';
  static const String line = 'line';
}

class Kpi {
  int? id;
  String? title;
  String? subtitle;
  String? type;
  int? line;
  dynamic results;

  Kpi({this.id, this.title, this.subtitle, this.type, this.line, this.results});

  factory Kpi.fromJson(Map<String, dynamic> json) => Kpi(
        id: json['id'],
        title: json['title'],
        subtitle: json['subtitle'],
        type: json['type'],
        line: json['line'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'subtitle': subtitle,
        'type': type,
        'line': line,
      };
}
