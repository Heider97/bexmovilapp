part of '../app_database.dart';

class RawQueryDao {
  final AppDatabase _appDatabase;

  RawQueryDao(this._appDatabase);

  List<RawQuery> parseQueries(List<Map<String, dynamic>> rawQueryList) {
    final rawQueries = <RawQuery>[];
    for (var rawQueryMap in rawQueryList) {
      final rawQuery = RawQuery.fromJson(rawQueryMap);
      rawQueries.add(rawQuery);
    }
    return rawQueries;
  }

  Future<List<RawQuery>> getAllQueries() async {
    final db = await _appDatabase.database;
    final rawQueryList = await db!.rawQuery(tableRawQueries);
    final rawQueries = parseQueries(rawQueryList);
    return rawQueries;
  }

  Future<RawQuery?> findRawQuery(int id, bool isSingle) async {
    final db = await _appDatabase.database;
    final rawQueryList = await db!
        .query(tableRawQueries, where: 'component_id = ?', whereArgs: [id]);
    final rawQuery = parseQueries(rawQueryList);
    if (rawQuery.isEmpty) {
      return null;
    }
    return rawQuery.first;
  }

  Future<int> insertRawQuery(RawQuery rawQuery) {
    return _appDatabase.insert(tableRawQueries, rawQuery.toJson());
  }

  Future<int> updateRawQuery(RawQuery rawQuery) {
    return _appDatabase.update(
        tableRawQueries, rawQuery.toJson(), 'id', rawQuery.id!);
  }

  Future<int> deleteRawQuery(RawQuery rawQuery) {
    return _appDatabase.delete(tableRawQueries, 'id', rawQuery.id!);
  }

  Future<int> deleteAll(int rawQueryId) {
    return _appDatabase.delete(tableQueries, 'id', rawQueryId);
  }

  Future<void> insertQueries(List<RawQuery> rawQueries) async {
    final db = await _appDatabase.database;
    var batch = db!.batch();

    if (rawQueries.isNotEmpty) {
      await Future.forEach(rawQueries, (rawQuery) async {
        var d = await db
            .query(tableRawQueries, where: 'id = ?', whereArgs: [rawQuery.id]);
        var w = parseQueries(d);
        if (w.isEmpty) {
          batch.insert(tableRawQueries, rawQuery.toJson());
        } else {
          batch.update(tableRawQueries, rawQuery.toJson(),
              where: 'id = ?', whereArgs: [rawQuery.id]);
        }
      });
    }
    await batch.commit(noResult: true);
    return Future.value();
  }

  Future<void> emptyRawQueries() async {
    final db = await _appDatabase.database;
    await db!.delete(tableRawQueries, where: 'id > 0');
    return Future.value();
  }
}
