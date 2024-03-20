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

  Future<RawQuery?> findRawQuery(int id) async {
    final db = await _appDatabase.database;
    final rawQueryList = await db!
        .query(tableRawQueries, where: 'id = ?', whereArgs: [id]);
    final rawQuery = parseQueries(rawQueryList);
    if (rawQuery.isEmpty) {
      return null;
    }
    return rawQuery.first;
  }

  Future<void> emptyRawQueries() async {
    final db = await _appDatabase.database;
    await db!.delete(tableRawQueries, where: 'id > 0');
    return Future.value();
  }
}
