import 'package:bexmovil/src/domain/models/client.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

import 'package:sqlbrite/sqlbrite.dart';
import 'package:synchronized/synchronized.dart';

//utils
import '../../../domain/models/feature.dart';
import '../../../utils/constants/strings.dart';

//models
import '../../../domain/models/location.dart';
import '../../../domain/models/processing_queue.dart';
import '../../../domain/models/config.dart';

//services
import '../../../locator.dart';
import '../../../services/storage.dart';

//daos
part '../local/dao/location_dao.dart';
part '../local/dao/config_dao.dart';
part '../local/dao/processing_queue_dao.dart';
part '../local/dao/feature_dao.dart';
part '../local/dao/client_dao.dart';

final LocalStorageService _storageService = locator<LocalStorageService>();

class AppDatabase {
  static var lock = Lock();
  static AppDatabase? _instance;
  static BriteDatabase? _streamDatabase;
  Database? _database;

  Future<AppDatabase?> getInstance() async {
    _instance ??= AppDatabase();
    _database ??= await database(1, null);
    return _instance;
  }

  Future<Database> _initDatabase(
      databaseName, int? version, List<String>? migrations) async {
    final documentsDirectory = await getApplicationDocumentsDirectory();

    final path = join(documentsDirectory.path, databaseName);

    return await openDatabase(
      path,
      version: version,
      onCreate: (db, version) async {
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
        if (migrations != null) {
          for (var migration in migrations) {
            try {
              String sqlScriptWithoutEscapes =
                  migration.replaceAll(RegExp(r'\\r\\n|\r\n|\n|\r'), ' ');

              List<String> scriptsSeparados =
                  sqlScriptWithoutEscapes.split('CREATE');

              for (String createTableScript in scriptsSeparados) {
                try {
                  String scriptCompleto = 'CREATE $createTableScript';
                  await db.execute(scriptCompleto);

                  print('Script ejecutado con éxito:\n');
                } catch (ex) {
                  print('Error al ejecutar el script:\n$ex');
                }
              }
            } catch (ex) {
              print('Error $ex');
            }
          }
        }
      },
    );
  }

  Future<Database?> database(int? version, List<String>? migrations) async {
    var dbName = _storageService.getString('company_name');
    if (_database != null) return _database;
    await lock.synchronized(() async {
      if (_database == null ||
          await _database!.database.getVersion() != version) {
        dbName ??= databaseName;
        _database = await _initDatabase('$dbName.db', version, migrations);
        _streamDatabase = BriteDatabase(_database!);
      }
    });
    return _database;
  }

  Future<BriteDatabase?> get streamDatabase async {
    await database(null, null);
    return _streamDatabase;
  }

  //SCRIPTING
  Future<void> runMigrations(List<String> migrations) async {
    final db = await _instance?.streamDatabase;
    try {
      await db?.transaction((db) async {
        for (var migration in migrations) {
          await db.execute(migration);
        }
      });
      return;
    } catch (er) {
      return;
    }
  }

  //INSERT METHOD
  Future<int> insert(String table, Map<String, dynamic> row) async {
    final db = await _instance?.streamDatabase;
    return db!.insert(table, row);
  }

  Future<List<int>?> insertAll(String table, List<dynamic> objects) async {
    final db = await _instance?.streamDatabase;
    var results = <int>[];
    try {
      await db?.transaction((db) async {
        for (var object in objects) {
          var id = await db.insert(table, object);
          results.add(id);
        }
      });
      return results;
    } catch (er) {
      print(er);
      return null;
    }
  }

  //UPDATE METHOD
  Future<int> update(
      String table, Map<String, dynamic> value, String columnId, int id) async {
    final db = await _instance?.streamDatabase;
    return db!.update(table, value, where: '$columnId = ?', whereArgs: [id]);
  }

  //DELETE METHOD
  Future<int> delete(String table, String columnId, int id) async {
    final db = await _instance?.streamDatabase;
    return db!.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }

  ProcessingQueueDao get processingQueueDao => ProcessingQueueDao(_instance!);

  FeatureDao get featureDao => FeatureDao(_instance!);

  ConfigDao get configDao => ConfigDao(_instance!);

  ClientDao get clientDao => ClientDao(_instance!);

  void close() {
    _database = null;
    _streamDatabase!.close();
  }
}
