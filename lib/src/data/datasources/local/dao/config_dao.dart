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

  Future<int> insertConfig(Config config) {
    return _appDatabase.insert(tableConfig, config.toMap());
  }

  Future<int> updateConfig(Config config) {
    return _appDatabase.update(
        tableConfig, config.toMap(), 'id', config.id!);
  }
}