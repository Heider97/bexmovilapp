part of '../app_database.dart';

class BlocEventDao {
  final AppDatabase _appDatabase;

  BlocEventDao(this._appDatabase);

  List<BlocEvent> parseBlocEvents(List<Map<String, dynamic>> moduleList) {
    final modules = <BlocEvent>[];
    for (var moduleMap in moduleList) {
      final module = BlocEvent.fromJson(moduleMap);
      modules.add(module);
    }
    return modules;
  }

  Future<BlocEvent?> findBlocEvent(String name) async {
    final db = await _appDatabase.database;
    var moduleList =
    await db!.query(tableBlocEvents, where: 'name = ?', whereArgs: [name]);
    var modules = parseBlocEvents(moduleList);
    if (modules.isNotEmpty) {
      return modules.first;
    }
    return null;
  }

  Future<void> insertBlocEvents(List<BlocEvent> modules) async {
    final db = await _appDatabase.database;
    var batch = db!.batch();

    await Future.forEach(modules, (module) async {
      var foundProduct = await db
          .query(tableBlocEvents, where: 'name = ?', whereArgs: [module.name]);

      if (foundProduct.isNotEmpty) {
        batch.update(tableBlocEvents, module.toJson(),
            where: 'name = ?', whereArgs: [module.name]);
      } else {
        batch.insert(tableBlocEvents, module.toJson());
      }
    });

    batch.commit(noResult: true, continueOnError: true);
  }

  Future<void> emptyBlocEvents() async {
    final db = await _appDatabase.database;
    await db!.delete(tableBlocEvents);
    return Future.value();
  }
}
