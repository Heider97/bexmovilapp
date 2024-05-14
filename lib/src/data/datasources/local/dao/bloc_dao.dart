part of '../app_database.dart';

class BlocDao {
  final AppDatabase _appDatabase;

  BlocDao(this._appDatabase);

  List<Bloc> parseBlocs(List<Map<String, dynamic>> moduleList) {
    final modules = <Bloc>[];
    for (var moduleMap in moduleList) {
      final module = Bloc.fromJson(moduleMap);
      modules.add(module);
    }
    return modules;
  }

  Future<Bloc?> findBloc(String name) async {
    final db = await _appDatabase.database;
    var moduleList =
    await db!.query(tableBlocs, where: 'name = ?', whereArgs: [name]);
    var modules = parseBlocs(moduleList);
    if (modules.isNotEmpty) {
      return modules.first;
    }
    return null;
  }

  Future<void> insertBlocs(List<Bloc> modules) async {
    final db = await _appDatabase.database;
    var batch = db!.batch();

    await Future.forEach(modules, (module) async {
      var foundProduct = await db
          .query(tableBlocs, where: 'name = ?', whereArgs: [module.name]);

      if (foundProduct.isNotEmpty) {
        batch.update(tableBlocs, module.toJson(),
            where: 'name = ?', whereArgs: [module.name]);
      } else {
        batch.insert(tableBlocs, module.toJson());
      }
    });

    batch.commit(noResult: true, continueOnError: true);
  }

  Future<void> emptyBlocs() async {
    final db = await _appDatabase.database;
    await db!.delete(tableBlocs);
    return Future.value();
  }
}
