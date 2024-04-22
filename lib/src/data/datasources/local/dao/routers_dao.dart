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

  List<Polyline> parsePolyline(List<Map<String, dynamic>> polylineList) {
    final polylines = <Polyline>[];
    for (var polyline in polylineList) {
      //REMPLAZAR POR EL CODIGO PARA CONVERITR EL STRING EN LIST<POLYLINES>
    }
    return polylines;
  }

  Future<List<Router>> getAllRoutersGroupByClient(String seller) async {
    final db = await _appDatabase.database;
    final routerList = await db!.rawQuery(
        "SELECT tr.*, COUNT(DISTINCT CODCLIENTE) AS CANTIDADCLIENTES, tdr.NOMDIARUTERO FROM tblmrutero tr, tblmdiarutero tdr WHERE tr.DIARUTERO = tdr.DIARUTERO AND tr.CODVENDEDOR = '$seller' GROUP BY tr.DIARUTERO");
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

  Future<void> savePolyline(String codeRouter, List<LatLng> polylines) async {
    final db = await _appDatabase.database;
    final polylineString = polylines
        .map((latLng) => '${latLng.latitude},${latLng.longitude}')
        .join(';');
    await db!.insert(
      'polylines',
      {'codeRouter': codeRouter, 'polylines': polylineString},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<LatLng>> getRouterPolylines(String codeRouter) async {
    final db = await _appDatabase.database;
    final result = await db!
        .query('polylines', where: 'codeRouter = ?', whereArgs: [codeRouter]);
    if (result.isEmpty) return [];

    final polylineString = result.first['polylines'] as String;
    final points = polylineString.split(';');
    return points.map((point) {
      final parts = point.split(',');
      return LatLng(double.parse(parts[0]), double.parse(parts[1]));
    }).toList();
  }

  Future<void> emptyRouters() async {
    final db = await _appDatabase.database;
    await db!.delete(tableRouter);
    return Future.value();
  }
}
