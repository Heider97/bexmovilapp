part of '../app_database.dart';

class RouterDao {
  final AppDatabase _appDatabase;

  RouterDao(this._appDatabase);

  List<Router> parseRouters(List<Map<String, dynamic>> routerList) {
    final routers = <Router>[];
    for (var routerMap in routerList) {
      final router = Router.fromJson(routerMap);
      routers.add(router);
    }
    return routers;
  }

  Future<List<Router>> getAllRoutersGroupByClient(String seller) async {
    final db = await _appDatabase.database;
    final routerList = await db!.query(tableRouter,
        where: 'codvendedor = ?', whereArgs: [seller], groupBy: 'codvendedor');
    final routers = parseRouters(routerList);
    return routers;
  }

  Future<List<Router>> getAllRouters(String seller) async {
    final db = await _appDatabase.database;
    final routerList = await db!.query(tableRouter, where: 'codvendedor = ?', whereArgs: [seller]);
    final routers = parseRouters(routerList);
    return routers;
  }

  Future<void> emptyRouters() async {
    final db = await _appDatabase.database;
    await db!.delete(tableRouter);
    return Future.value();
  }
}