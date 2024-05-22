part of '../app_database.dart';

class LogicDao {
  final AppDatabase _appDatabase;

  LogicDao(this._appDatabase);

  List<Logic> parseQueries(List<Map<String, dynamic>> logicList) {
    final logics = <Logic>[];
    for (var logicMap in logicList) {
      final logic = Logic.fromJson(logicMap);
      logics.add(logic);
    }
    return logics;
  }

  Future<Logic?> findLogic(int id) async {
    final db = await _appDatabase.database;
    final logicList =
        await db!.query(tableLogics, where: 'id = ?', whereArgs: [id]);
    final logic = parseQueries(logicList);
    if (logic.isEmpty) {
      return null;
    }
    return logic.first;
  }

  Future<bool> validateLogic(Logic logic, String seller) async {
    final db = await _appDatabase.database;
    final v = await db!.query(logic.table!,
        where: '${logic.column} = ? and codvendedor = ?', whereArgs: [logic.condition, seller]);

    if (v.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> emptyQueries() async {
    final db = await _appDatabase.database;
    await db!.delete(q.tableQueries, where: 'id > 0');
    return Future.value();
  }
}
