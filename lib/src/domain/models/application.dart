const String tableKpis = 'applications';

class ApplicationFields {
  static final List<String> values = [id, title, svg, status, route];

  static const String id = 'id';
  static const String title = 'title';
  static const String svg = 'svg';
  static const String status = 'status';
  static const String route = 'route';
}

class Application {
  int? id;
  String? title;
  String? svg;
  bool? status;
  String? route;

  Application({
    this.id,
    this.title,
    this.svg,
    this.status,
    this.route,
  });

  factory Application.fromJson(Map<String, dynamic> json) => Application(
    id: json["id"],
    title: json["title"],
    svg: json["svg"],
    status: json["status"],
    route: json["route"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "svg": svg,
    "status": status,
    "route": route,
  };
}
