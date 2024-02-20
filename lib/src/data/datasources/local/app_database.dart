import 'package:bexmovil/src/domain/models/client.dart';
import 'package:bexmovil/src/domain/models/responses/kpi_response.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

import 'package:sqflite/sqflite.dart';
import 'package:synchronized/synchronized.dart';

//utils
import '../../../domain/models/feature.dart';
import '../../../utils/constants/strings.dart';

//models
import '../../../domain/models/location.dart';
import '../../../domain/models/processing_queue.dart';
import '../../../domain/models/config.dart';
import '../../../domain/models/kpi.dart';
import '../../../domain/models/router.dart';

//services
import '../../../locator.dart';
import '../../../services/storage.dart';

//daos
part '../local/dao/location_dao.dart';
part '../local/dao/config_dao.dart';
part '../local/dao/processing_queue_dao.dart';
part '../local/dao/feature_dao.dart';
part '../local/dao/client_dao.dart';
part '../local/dao/kpi_dao.dart';
part '../local/dao/routers_dao.dart';

final LocalStorageService _storageService = locator<LocalStorageService>();

class AppDatabase {
  static var lock = Lock();
  AppDatabase._privateConstructor();
  static final AppDatabase instance = AppDatabase._privateConstructor();

  Database? _database;

  Future<Database> _initDatabase(databaseName) async {
    final documentsDirectory = await getApplicationDocumentsDirectory();

    final path = join(documentsDirectory.path, databaseName);

    return await openDatabase(path, version: 2, onCreate: (db, version) async {
      await db.execute('''
          CREATE TABLE $tableLocations (
            ${LocationFields.id} INTEGER PRIMARY KEY,
            ${LocationFields.latitude} REAL DEFAULT NULL,
            ${LocationFields.longitude} REAL DEFAULT NULL,
            ${LocationFields.accuracy} REAL DEFAULT NULL,
            ${LocationFields.altitude} REAL DEFAULT NULL,
            ${LocationFields.speed} REAL DEFAULT NULL,
            ${LocationFields.speedAccuracy} REAL DEFAULT NULL,
            ${LocationFields.heading} REAL DEFAULT NULL,
            ${LocationFields.isMock} BOOLEAN DEFAULT NULL,
            ${LocationFields.createdAt} TEXT DEFAULT NULL
          )
        ''');
      await db.execute('''
          CREATE TABLE $tableProcessingQueues (
            ${ProcessingQueueFields.id} INTEGER PRIMARY KEY,
            ${ProcessingQueueFields.body} TEXT DEFAULT NULL,
            ${ProcessingQueueFields.task} TEXT DEFAULT NULL,
            ${ProcessingQueueFields.code} TEXT DEFAULT NULL,
            ${ProcessingQueueFields.error} TEXT DEFAULT NULL,
            ${ProcessingQueueFields.createdAt} TEXT DEFAULT NULL,
            ${ProcessingQueueFields.updatedAt} TEXT DEFAULT NULL
          )
        ''');
      await db.execute('''
          CREATE TABLE $tableFeature (
            ${FeaturesFields.coddashboard} INTEGER PRIMARY KEY,
            ${FeaturesFields.codvendedor} TEXT DEFAULT NULL,
            ${FeaturesFields.descripcion} TEXT DEFAULT NULL,
            ${FeaturesFields.urldesc} TEXT DEFAULT NULL,
            ${FeaturesFields.categoria} TEXT DEFAULT NULL,
            ${FeaturesFields.codcliente} TEXT DEFAULT NULL,
            ${FeaturesFields.fechaevento} TEXT DEFAULT NULL,
            ${FeaturesFields.fechafinevento} TEXT DEFAULT NULL,
            ${FeaturesFields.fecgra} TEXT DEFAULT NULL,
            ${FeaturesFields.requerido} TEXT DEFAULT NULL,
            ${FeaturesFields.createdById} INTEGER DEFAULT NULL,
            ${FeaturesFields.createdAt} TEXT DEFAULT NULL,
            ${FeaturesFields.updatedAt} TEXT DEFAULT NULL,
            ${FeaturesFields.deletedAt} TEXT DEFAULT NULL
          )
        ''');
      await db.execute('''
          CREATE TABLE $tableConfig (
            ${ConfigFields.id} INTEGER PRIMARY KEY,
            ${ConfigFields.name} TEXT DEFAULT NULL,
            ${ConfigFields.type} TEXT DEFAULT NULL,
            ${ConfigFields.value} TEXT DEFAULT NULL,
            ${ConfigFields.module} TEXT DEFAULT NULL
          )
        ''');
      await db.execute('''
          CREATE TABLE IF NOT EXISTS $tableKpis (
            ${KpiFields.id} INTEGER PRIMARY KEY,
            ${KpiFields.title} TEXT DEFAULT NULL,
            ${KpiFields.sql} TEXT DEFAULT NULL,
            ${KpiFields.type} TEXT DEFAULT NULL,
            ${KpiFields.line} INTEGER DEFAULT NULL,
            ${KpiFields.value} TEXT DEFAULT NULL
          )
        ''');
    }, onUpgrade: (db, oldVersion, newVersion) async {
      await db.execute('''
           CREATE TABLE IF NOT EXISTS $tableKpis (
            ${KpiFields.id} INTEGER PRIMARY KEY,
            ${KpiFields.title} TEXT DEFAULT NULL,
            ${KpiFields.sql} TEXT DEFAULT NULL,
            ${KpiFields.type} TEXT DEFAULT NULL,
            ${KpiFields.line} INTEGER DEFAULT NULL,
            ${KpiFields.value} TEXT DEFAULT NULL
          )
        ''');
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

  Future<List<Map<String, Object?>>> findGlobal(String table, String condition, String value) async {
    final db = await instance.database;
    return await db!.query(table, where: '$condition = ?', whereArgs: [value]);
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

  void close() {
    _database!.close();
    _database = null;
  }
}
