part of '../app_database.dart';

class ConfigDao {
  final AppDatabase _appDatabase;

  ConfigDao(this._appDatabase);

  List<Config> parseConfigs(List<Map<String, dynamic>> configList) {
    final configs = <Config>[];
    for (var configMap in configList) {
      final config = Config.fromMap(configMap);
      configs.add(config);
    }
    return configs;
  }

  Future<List<Config>> getAllConfigs() async {
    final db = await _appDatabase.streamDatabase;
    final configList = await db!.query(tableConfig);
    final configs = parseConfigs(configList);
    return configs;
  }

  Future<void> insertConfigs(List<Config> configs) async {
    final db = await _appDatabase.streamDatabase;
    var batch = db!.batch();

    await Future.forEach(configs, (config) async {
      var foundProduct = await db.query(tableConfig, where: 'name = ?', whereArgs: [config.name]);

      if(foundProduct.isNotEmpty){
        batch.update(tableConfig, config.toMap(), where: 'name = ?', whereArgs: [config.name]);
      } else {
        batch.insert(tableConfig, config.toMap());
      }
    });

    batch.commit(noResult: true, continueOnError: true);
  }

  Future<int> insertConfig(Config config) {
    return _appDatabase.insert(tableConfig, config.toMap());
  }

  Future<int> updateConfig(Config config) {
    return _appDatabase.update(
        tableConfig, config.toMap(), 'id', config.id!);
  }

  Future<void> emptyConfigs() async {
    final db = await _appDatabase.streamDatabase;
    await db!.delete(tableConfig);
    return Future.value();
  }
}