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

  Future<List<Kpi>> getAllKpis() async {
    final db = _appDatabase._database;
    final kpiList = await db!.query('app_kpis');
    final kpis = parseKpis(kpiList);
    return kpis;
  }

  Future<int> insertKpi(Kpi kpi) {
    return _appDatabase.insert('app_kpis', kpi.toJson());
  }

  Future<int> updateKpi(Kpi kpi) {
    return _appDatabase.update('app_kpis', kpi.toJson(), 'id', kpi.id!);
  }

  Future<void> emptyKpis() async {
    final db = _appDatabase._database;
    db!.delete('tblmkpie');
    return Future.value();
  }
}
