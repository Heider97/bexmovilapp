part of '../app_database.dart';

class FilterDao {
  final AppDatabase _appDatabase;

  FilterDao(this._appDatabase);

  List<Filter> parseFilter(List<Map<String, dynamic>> filterLists) {
    final filters = <Filter>[];
    for (var filterMap in filterLists) {
      final client = Filter.fromJson(filterMap);
      filters.add(client);
    }
    return filters;
  }

  Future<List<Filter>> getAllFilters() async {
    final db = await _appDatabase.database;
    final filterList = await db!.query(tableFilter);
    final filter = parseFilter(filterList);
    return filter;
  }

  Future<int> insertFilter(Filter filter) {
    return _appDatabase.insert(tableFilter, filter.toJson());
  }

  Future<void> insertFilters(List<Filter> filters) async {
    final db = await _appDatabase.database;
    var batch = db!.batch();

    await Future.forEach(filters, (filter) async {
      var foundProduct = await db
          .query(tableFilter, where: 'name = ?', whereArgs: [filter.name]);

      if (foundProduct.isNotEmpty) {
        batch.update(tableFilter, filter.toJson(),
            where: 'coddashboard = ?', whereArgs: [filter.name]);
      } else {
        batch.insert(tableFilter, filter.toJson());
      }
    });

    batch.commit(noResult: true, continueOnError: true);
  }

  Future<int> updateFilter(Filter filter) {
    return _appDatabase.update(tableFilter, filter.toJson(), 'id', filter.id!);
  }

  Future<void> emptyFilters() async {
    final db = await _appDatabase.database;
    await db!.delete(tableFilter);
    return Future.value();
  }
}
