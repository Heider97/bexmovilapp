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

  Future<List<Query>> getAllQueries() async {
    final db = await _appDatabase.database;
    final queryList = await db!.query(tableQueries);
    final queries = parseQueries(queryList);
    return queries;
  }

  Future<Query?> findQuery(int id) async {
    final db = await _appDatabase.database;
    final queryList =
    await db!.query(tableQueries, where: 'component_id = ?', whereArgs: [id]);
    final query = parseQueries(queryList);
    if(query.isEmpty){
      return null;
    }
    return query.first;
  }

  Future<int> insertQuery(Query query) {
    return _appDatabase.insert(tableQueries, query.toJson());
  }

  Future<int> updateQuery(Query query) {
    return _appDatabase.update(tableQueries, query.toJson(), 'id', query.id!);
  }

  Future<int> deleteQuery(Query query){
    return _appDatabase.delete(tableQueries, 'id', query.id!);
  }

  Future<int> deleteAll(int queryId){
    return _appDatabase.delete(tableQueries, 'id', queryId);
  }

  Future<void> insertQueries(List<Query> queries) async {
    final db = await _appDatabase.database;
    var batch = db!.batch();

    if (queries.isNotEmpty) {
      await Future.forEach(queries, (query) async {
        var d = await db.query(tableQueries, where: 'id = ?', whereArgs: [query.id]);
        var w = parseQueries(d);
        if (w.isEmpty) {
          batch.insert(tableQueries, query.toJson());
        } else {
          batch.update(tableQueries, query.toJson(), where: 'id = ?', whereArgs: [query.id]);
        }
      });
    }
    await batch.commit(noResult: true);
    return Future.value();
  }

  Future<void> emptyQueries() async {
    final db = await _appDatabase.database;
    await db!.delete(tableQueries, where: 'id > 0');
    return Future.value();
  }
}
