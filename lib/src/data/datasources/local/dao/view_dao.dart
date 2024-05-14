part of '../app_database.dart';

class ViewDao {
  final AppDatabase _appDatabase;

  ViewDao(this._appDatabase);

  List<View> parseViews(List<Map<String, dynamic>> moduleList) {
    final modules = <View>[];
    for (var moduleMap in moduleList) {
      final module = View.fromJson(moduleMap);
      modules.add(module);
    }
    return modules;
  }

  Future<View?> findView(String name) async {
    final db = await _appDatabase.database;
    var moduleList =
    await db!.query(tableViews, where: 'name = ?', whereArgs: [name]);
    var modules = parseViews(moduleList);
    if (modules.isNotEmpty) {
      return modules.first;
    }
    return null;
  }

  Future<void> insertViews(List<View> modules) async {
    final db = await _appDatabase.database;
    var batch = db!.batch();

    await Future.forEach(modules, (module) async {
      var foundProduct = await db
          .query(tableViews, where: 'name = ?', whereArgs: [module.name]);

      if (foundProduct.isNotEmpty) {
        batch.update(tableViews, module.toJson(),
            where: 'name = ?', whereArgs: [module.name]);
      } else {
        batch.insert(tableViews, module.toJson());
      }
    });

    batch.commit(noResult: true, continueOnError: true);
  }

  Future<void> emptyViews() async {
    final db = await _appDatabase.database;
    await db!.delete(tableViews);
    return Future.value();
  }
}
