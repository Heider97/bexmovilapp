const String tableViews = 'app_views';

class ViewFields {
  static final List<String> values = [id, name, createdAt, appBlocId, route];

  static const String id = 'id';
  static const String name = 'name';
  static const String createdAt = 'createdAt';
  static const String route = 'route';
  static const String appBlocId = 'appBlocId';
}

class View {
  int? id;
  String? name;
  String? createdAt;
  bool? appBlocId;
  String? route;

  View({
    this.id,
    this.name,
    this.createdAt,
    this.appBlocId,
    this.route,
  });

  factory View.fromJson(Map<String, dynamic> json) => View(
    id: json["id"],
    name: json["name"],
    createdAt: json["createdAt"],
    appBlocId: json["appBlocId"] != null
        ? json['appBlocId'] == 1
        ? true
        : false
        : null,
    route: json["route"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "createdAt": createdAt,
    "appBlocId": appBlocId,
    "route": route,
  };
}
