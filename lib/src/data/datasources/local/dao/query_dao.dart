part of '../app_database.dart';

class QueryDao {
  final AppDatabase _appDatabase;

  QueryDao(this._appDatabase);

  List<Query> parseQueries(List<Map<String, dynamic>> queryList) {
    final queries = <Query>[];
    for (var queryMap in queryList) {
      final query = Query.fromJson(queryMap);
      queries.add(query);
    }
    return queries;
  }

  Future<Query?> findQuery(int id) async {
    final db = await _appDatabase.database;
    final queryList = await db!.query(tableQueries, where: 'id = ?', whereArgs: [id]);
    final query = parseQueries(queryList);
    if(query.isEmpty){
      return null;
    }
    return query.first;
  }

  Future<void> emptyQueries() async {
    final db = await _appDatabase.database;
    await db!.delete(tableQueries, where: 'id > 0');
    return Future.value();
  }
}
