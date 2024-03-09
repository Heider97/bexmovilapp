import 'dart:convert';
import 'package:bexmovil/src/domain/models/invoice.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:synchronized/synchronized.dart';

//utils
import '../../../utils/constants/strings.dart';

//models
import '../../../domain/abstracts/format_abstract.dart';
import '../../../domain/models/location.dart';
import '../../../domain/models/processing_queue.dart';
import '../../../domain/models/config.dart';
import '../../../domain/models/kpi.dart';
import '../../../domain/models/router.dart';
import '../../../domain/models/application.dart';
import '../../../domain/models/graphic.dart';
import '../../../domain/models/feature.dart';
import '../../../domain/models/client.dart';
import '../../../domain/models/error.dart';
import '../../../domain/models/filter.dart';
import '../../../domain/models/option.dart';
import '../../../domain/models/invoice.dart';
import '../../../domain/models/query.dart';

//services
import '../../../locator.dart';
import '../../../services/storage.dart';

//migrations
part 'migrations/index.dart';

//daos
part '../local/dao/location_dao.dart';
part '../local/dao/config_dao.dart';
part '../local/dao/processing_queue_dao.dart';
part '../local/dao/feature_dao.dart';
part '../local/dao/client_dao.dart';
part '../local/dao/kpi_dao.dart';
part '../local/dao/routers_dao.dart';
part '../local/dao/application_dao.dart';
part '../local/dao/graphic_dao.dart';
part '../local/dao/error_dao.dart';
part '../local/dao/filter_dao.dart';
part '../local/dao/option_dao.dart';
part '../local/dao/query_dao.dart';

final LocalStorageService _storageService = locator<LocalStorageService>();

class AppDatabase {
  static var lock = Lock();
  AppDatabase._privateConstructor();
  static final AppDatabase instance = AppDatabase._privateConstructor();

  Database? _database;

  Future<Database> _initDatabase(databaseName) async {
    final documentsDirectory = await getApplicationDocumentsDirectory();

    final path = join(documentsDirectory.path, databaseName);

    return await openDatabase(path,
        version: 3,
        onCreate: onCreate,
        onUpgrade: (db, oldVersion, newVersion) async {

        });
  }

  Future<Database?> get database async {
    var dbName = _storageService.getString('company_name');
    if (_database != null) return _database;
    await lock.synchronized(() async {
      if (_database == null) {
        dbName ??= databaseName;
        _database = await _initDatabase('$dbName.db');
      }
    });
    return _database;
  }

  //SCRIPTING
  Future<void> runMigrations(List<String> migrations) async {
    final db = await instance.database;
    try {
      await db?.transaction((database) async {
        for (var migration in migrations) {
          await database.execute(migration);
        }
      });
      return;
    } catch (er) {
      return;
    }
  }

  Future<bool> listenForTableChanges(String? table) async {
    final db = await instance.database;
    var result = await db!.rawQuery('SELECT changes($table)');
    return result.isNotEmpty;
  }

  Future<List<Map<String, Object?>>> query(
      String query, String type, String? where, List<dynamic>? values) async {
    final db = await instance.database;
    if (type == 'query') {
      return await db!.query(query, where: where, whereArgs: values);
    } else {
      return await db!.rawQuery(query);
    }
  }

  Future<List<Map<String, Object?>>> search(String table) async {
    final db = await instance.database;
    return await db!.query(table);
  }

  //INSERT METHOD
  Future<int> insert(String table, Map<String, dynamic> row) async {
    final db = await instance.database;
    return db!.insert(table, row);
  }

  Future<List<int>?> insertAll(String table, List<dynamic> objects) async {
    final db = await instance.database;
    var results = <int>[];
    try {
      await db?.transaction((database) async {
        final batch = database.batch();
        for (var object in objects) {
          batch.insert(table, object);
        }
        await batch.commit(continueOnError: false);
      });
      return results;
    } catch (er) {
      return null;
    }
  }

  //UPDATE METHOD
  Future<int> update(
      String table, Map<String, dynamic> value, String columnId, int id) async {
    final db = await instance.database;
    return db!.update(table, value, where: '$columnId = ?', whereArgs: [id]);
  }

  //DELETE METHOD
  Future<int> delete(String table, String columnId, int id) async {
    final db = await instance.database;
    return db!.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }

  ProcessingQueueDao get processingQueueDao => ProcessingQueueDao(instance);

  FeatureDao get featureDao => FeatureDao(instance);

  ConfigDao get configDao => ConfigDao(instance);

  ClientDao get clientDao => ClientDao(instance);

  KpiDao get kpiDao => KpiDao(instance);

  RouterDao get routerDao => RouterDao(instance);

  ApplicationDao get applicationDao => ApplicationDao(instance);

  GraphicDao get graphicDao => GraphicDao(instance);

  LocationDao get locationDao => LocationDao(instance);

  ErrorDao get errorDao => ErrorDao(instance);

  FilterDao get filterDao => FilterDao(instance);

  OptionDao get optionDao => OptionDao(instance);

  QueryDao get queryDao => QueryDao(instance);

  void close() {
    _database!.close();
    _database = null;
  }
}
