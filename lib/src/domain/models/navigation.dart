const String tableNavigations = 'app_navigations';

class NavigationFields {
  static final List<String> values = [
    id,
    route,
    type,
    arguments,
  ];

  static const String id = 'id';
  static const String route = '`route`';
  static const String type = 'type';
  static const String arguments = 'arguments';
}

class Navigation {
  Navigation({this.id, this.route, this.arguments, this.type});

  Navigation copy({
    int? id,
    String? route,
    String? arguments,
    String? type,
  }) =>
      Navigation(
        id: id ?? this.id,
        route: route ?? this.route,
        arguments: arguments ?? this.arguments,
        type: type ?? this.type,
      );

  Navigation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    route = json['route'];
    arguments = json['arguments'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['route'] = route;
    data['arguments'] = arguments;
    data['type'] = type;
    return data;
  }

  int? id;
  String? route;
  String? arguments;
  String? type;
}
