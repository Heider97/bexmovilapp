part of '../app_database.dart';

class QueryDao {
  final AppDatabase _appDatabase;

  QueryDao(this._appDatabase);

  List<Query> parseQuerys(List<Map<String, dynamic>> queryList) {
    final querys = <Query>[];
    for (var queryMap in queryList) {
      final query = Query.fromJson(queryMap);
      querys.add(query);
    }
    return querys;
  }

  Future<List<Query>> getAllQueries() async {
    final db = await _appDatabase.database;
    final queryList = await db!.query(tableQueries);
    final queries = parseQuerys(queryList);
    return queries;
  }

  Future<Query?> findQuery(int id) async {
    final db = await _appDatabase.database;
    final queryList =
    await db!.query(tableQueries, where: 'id = ?', whereArgs: [id]);
    final query = parseQuerys(queryList);
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

  Future<void> insertQuerys(List<Query> querys) async {
    final db = await _appDatabase.database;
    var batch = db!.batch();

    if (querys.isNotEmpty) {
      await Future.forEach(querys, (query) async {
        var d = await db.query(tableQueries, where: 'id = ?', whereArgs: [query.id]);
        var w = parseQuerys(d);
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
