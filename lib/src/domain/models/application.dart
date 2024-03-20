const String tableApplications = 'app_functionalities';

class ApplicationFields {
  static final List<String> values = [id, title, svg, enabled, route];

  static const String id = 'id';
  static const String title = 'title';
  static const String svg = 'svg';
  static const String route = 'route';
  static const String enabled = 'enabled';
}

class Application {
  int? id;
  String? title;
  String? svg;
  bool? enabled;
  String? route;

  Application({
    this.id,
    this.title,
    this.svg,
    this.enabled,
    this.route,
  });

  factory Application.fromJson(Map<String, dynamic> json) => Application(
        id: json["id"],
        title: json["title"],
        svg: json["svg"],
        enabled: json["enabled"] != null
            ? json['enabled'] == 1
                ? true
                : false
            : null,
        route: json["route"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "svg": svg,
        "enabled": enabled,
        "route": route,
      };
}
