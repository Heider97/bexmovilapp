part of '../app_database.dart';

class KpiDao {
  final AppDatabase _appDatabase;

  KpiDao(this._appDatabase);

  List<Kpi> parseKpis(List<Map<String, dynamic>> kpiList) {
    final kpis = <Kpi>[];
    for (var kpiMap in kpiList) {
      final kpi = Kpi.fromJson(kpiMap);
      kpis.add(kpi);
    }
    return kpis;
  }

  Future<List<Kpi>> getKpisByLine(String line) async {
    final db = _appDatabase._database;
    final kpiList =
        await db!.query(tableKpis, where: 'line = ?', whereArgs: [line]);
    final kpis = parseKpis(kpiList);
    return kpis;
  }

  Future<void> insertKpis(List<Kpi> kpis) async {
    final db = _appDatabase._database;
    var batch = db!.batch();

    await Future.forEach(kpis, (feature) async {
      var foundProduct =
          await db.query(tableKpis, where: 'id = ?', whereArgs: [feature.id]);

      if (foundProduct.isNotEmpty) {
        batch.update(tableKpis, feature.toJson(),
            where: 'id = ?', whereArgs: [feature.id]);
      } else {
        batch.insert(tableKpis, feature.toJson());
      }
    });

    batch.commit(noResult: true, continueOnError: true);
  }

  Future<int> insertKpi(Kpi kpi) {
    return _appDatabase.insert(tableKpis, kpi.toJson());
  }

  Future<int> updateKpi(Kpi kpi) {
    return _appDatabase.update(tableKpis, kpi.toJson(), 'id', kpi.id!);
  }

  Future<void> emptyKpis() async {
    final db = _appDatabase._database;
    db!.delete(tableKpis);
    return Future.value();
  }
}
