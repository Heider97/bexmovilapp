import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite_migration/sqflite_migration.dart';
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

final LocalStorageService _storageService = locator<LocalStorageService>();

class AppDatabase {
  static BriteDatabase? _streamDatabase;
  // make this a singleton class
  // ignore: sort_constructors_first
  AppDatabase._privateConstructor();
  static final AppDatabase instance = AppDatabase._privateConstructor();
  static var lock = Lock();

  static Database? _database;

  Future<Database> _initDatabase(
      databaseName, int version, List<String>? migrations) async {
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
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion <= 2) {
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
        }
      },
    );
  }

  Future<Database?> database(String? version, List<String> migrations) async {
    var dbName = _storageService.getString('company_name');

    if (_database != null) return _database;
    await lock.synchronized(() async {
      if (_database == null) {
        dbName ??= databaseName;
        _database = await _initDatabase(
            '$dbName.db', int.parse(version ?? "1"), migrations);
        _streamDatabase = BriteDatabase(_database!);
      }
    });
    return _database;
  }

  Future<BriteDatabase?> get streamDatabase async {
    await database(null, []);
    return _streamDatabase;
  }

  //INSERT METHODS
  Future<int> insert(String table, Map<String, dynamic> row) async {
    final db = await instance.streamDatabase;
    return db!.insert(table, row);
  }

  //UPDATE METHODS
  Future<int> update(
      String table, Map<String, dynamic> value, String columnId, int id) async {
    final db = await instance.streamDatabase;
    return db!.update(table, value, where: '$columnId = ?', whereArgs: [id]);
  }

  // //DELETE  */METHODS
  Future<int> delete(String table, String columnId, int id) async {
    final db = await instance.streamDatabase;
    return db!.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }

  ProcessingQueueDao get processingQueueDao => ProcessingQueueDao(instance);

  FeatureDao get featureDao => FeatureDao(instance);

  ConfigDao get configDao => ConfigDao(instance);

  void close() {
    _database = null;
    _streamDatabase!.close();
  }
}
