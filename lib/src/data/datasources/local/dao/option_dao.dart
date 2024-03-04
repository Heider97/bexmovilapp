part of '../app_database.dart';

class OptionDao {
  final AppDatabase _appDatabase;

  OptionDao(this._appDatabase);

  List<Option> parseOption(List<Map<String, dynamic>> optionLists) {
    final options = <Option>[];
    for (var optionMap in optionLists) {
      final client = Option.fromJson(optionMap);
      options.add(client);
    }
    return options;
  }

  Future<List<Option>> getAllOptionsByFilter(int filterId) async {
    final db = await _appDatabase.database;
    final optionList =
        await db!.query(tableOption, where: 'filter_id', whereArgs: [filterId]);
    final option = parseOption(optionList);
    return option;
  }

  Future<int> insertOption(Option option) {
    return _appDatabase.insert(tableOption, option.toJson());
  }

  Future<void> insertOptions(List<Option> options) async {
    final db = await _appDatabase.database;
    var batch = db!.batch();

    await Future.forEach(options, (option) async {
      var foundProduct = await db
          .query(tableOption, where: 'name = ?', whereArgs: [option.name]);

      if (foundProduct.isNotEmpty) {
        batch.update(tableOption, option.toJson(),
            where: 'name = ?', whereArgs: [option.name]);
      } else {
        batch.insert(tableOption, option.toJson());
      }
    });

    batch.commit(noResult: true, continueOnError: true);
  }

  Future<int> updateOption(Option option) {
    return _appDatabase.update(tableOption, option.toJson(), 'id', option.id!);
  }

  Future<void> emptyOptions() async {
    final db = await _appDatabase.database;
    await db!.delete(tableOption);
    return Future.value();
  }
}
