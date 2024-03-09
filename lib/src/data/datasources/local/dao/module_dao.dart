part of '../app_database.dart';

class ModuleDao {
  final AppDatabase _appDatabase;

  ModuleDao(this._appDatabase);

  List<Module> parseModules(List<Map<String, dynamic>> moduleList) {
    final modules = <Module>[];
    for (var moduleMap in moduleList) {
      final module = Module.fromJson(moduleMap);
      modules.add(module);
    }
    return modules;
  }

  Future<void> insertModules(List<Module> modules) async {
    final db = await _appDatabase.database;
    var batch = db!.batch();

    await Future.forEach(modules, (module) async {
      var foundProduct = await db.query(tableModules, where: 'name = ?', whereArgs: [module.name]);

      if(foundProduct.isNotEmpty){
        batch.update(tableModules, module.toJson(), where: 'name = ?', whereArgs: [module.name]);
      } else {
        batch.insert(tableModules, module.toJson());
      }
    });

    batch.commit(noResult: true, continueOnError: true);
  }


  Future<void> emptyModules() async {
    final db = await _appDatabase.database;
    await db!.delete(tableModules);
    return Future.value();
  }
}