//domain
import '../../domain/models/config.dart';
import '../../domain/models/router.dart';

List<Router> parseRouters(List<Map<String, dynamic>> routerList) {
  final routers = <Router>[];
  for (var routerMap in routerList) {
    final router = Router.fromJson(routerMap);
    routers.add(router);
  }
  return routers;
}

class AppDynamicCasterType<T> {
  final T Function(String) fromString;
  AppDynamicCasterType(this.fromString);
}

class AppDynamicListCasterType<T> {
  final T Function(List<Map<String, Object?>>) fromMap;
  AppDynamicListCasterType(this.fromMap);
}

Map<String, AppDynamicCasterType> dynamicTypes = {
  "int": AppDynamicCasterType<int>((s) => int.parse(s)),
  "double": AppDynamicCasterType<double>((s) => double.parse(s)),
  "bool": AppDynamicCasterType<bool>((s) => bool.parse(s)),
};

Map<String, AppDynamicListCasterType> dynamicListTypes = {
  "List<Router>": AppDynamicListCasterType<List<Router>>((s) => parseRouters(s)),
};

Future<dynamic> generateVariable(Config config) async {
  return null;
}