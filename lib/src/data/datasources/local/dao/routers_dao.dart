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
    final routerList = await db!.rawQuery(
        "SELECT tr.*, COUNT(DISTINCT CODCLIENTE) AS CANTIDADCLIENTES, tdr.NOMDIARUTERO FROM tblmrutero tr, tblmdiarutero tdr WHERE tr.DIARUTERO = tdr.DIARUTERO AND tr.CODVENDEDOR = '$seller' GROUP BY tr.DIARUTERO");
    final routers = parseRouters(routerList);
    return routers;
  }

  Future<List<Router>> getAllClientsRouter(
      String seller, String dayRouter) async {
    final db = await _appDatabase.database;
    final routerList = await db!.rawQuery(
        "SELECT tr.codprecio, tr.inactivo, c.razcliente, tr.diarutero FROM tblmrutero tr INNER JOIN tblmdiarutero tdr ON tr.diarutero = tdr.diarutero INNER JOIN tblmcliente c ON tr.codcliente = c.codcliente WHERE tr.DIARUTERO = '$dayRouter' AND tr.CODVENDEDOR = '$seller' GROUP BY tr.CODCLIENTE");
    final routers = parseRouters(routerList);
    return routers;
  }

  Future<List<Router>> getAllRouters(String seller) async {
    final db = await _appDatabase.database;
    final routerList = await db!
        .query(tableRouter, where: 'codvendedor = ?', whereArgs: [seller]);
    final routers = parseRouters(routerList);
    return routers;
  }

  Future<void> emptyRouters() async {
    final db = await _appDatabase.database;
    await db!.delete(tableRouter);
    return Future.value();
  }
}
