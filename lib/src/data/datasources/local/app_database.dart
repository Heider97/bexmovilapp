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
  late int version;
  late List<String> migrations;

  static AppDatabase? instance;
  static BriteDatabase? _streamDatabase;
  Database? _database;

  AppDatabase({required this.version, required this.migrations});

  Future<AppDatabase?> getInstance() async {
    instance ??= AppDatabase(version: version, migrations: migrations);
    _database ??= await database;
    return instance;
  }

  static var lock = Lock();

  Future<Database> _initDatabase(
      databaseName, int version, List<String>? migrations) async {
    final documentsDirectory = await getApplicationDocumentsDirectory();

    final path = join(documentsDirectory.path, databaseName);

    print('incoming version');
    print(version);

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
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        print('************');
        print(newVersion);
        print(oldVersion);

        // for (var i = oldVersion - 1; i <= newVersion - 1; i++) {
        //   if (migrations != null) {
        //     for (var migration in migrations) {
        //       try {
        //         String sqlScriptWithoutEscapes =
        //             migration.replaceAll(RegExp(r'\\r\\n|\r\n|\n|\r'), ' ');
        //
        //         List<String> scriptsSeparados =
        //             sqlScriptWithoutEscapes.split('CREATE');
        //
        //         for (String createTableScript in scriptsSeparados) {
        //           try {
        //             String scriptCompleto = 'CREATE $createTableScript';
        //             await db.execute(scriptCompleto);
        //
        //             print('Script ejecutado con éxito:\n');
        //           } catch (ex) {
        //             print('Error al ejecutar el script:\n$ex');
        //           }
        //         }
        //       } catch (ex) {
        //         print('Error $ex');
        //       }
        //     }
        //   }
        // }
      },
    );
  }

  Future<Database?> get database async {
    var dbName = _storageService.getString('company_name');
    if (_database != null) {
      var currentVersion = await _database!.database.getVersion();

      print(currentVersion);

      if (version != null && currentVersion != version) {
        print('inicializando database');
        _database = await _initDatabase('$dbName.db', version, migrations);
      }
      return _database;
    }
    await lock.synchronized(() async {
      if (_database == null) {
        dbName ??= databaseName;
        _database = await _initDatabase('$dbName.db', version ?? 1, migrations);
        _streamDatabase = BriteDatabase(_database!);
      }
    });
    return _database;
  }

  Future<BriteDatabase?> get streamDatabase async {
    await database;
    return _streamDatabase;
  }

  //INSERT METHOD
  Future<int> insert(String table, Map<String, dynamic> row) async {
    final db = await instance?.streamDatabase;
    return db!.insert(table, row);
  }

  //UPDATE METHOD
  Future<int> update(
      String table, Map<String, dynamic> value, String columnId, int id) async {
    final db = await instance?.streamDatabase;
    return db!.update(table, value, where: '$columnId = ?', whereArgs: [id]);
  }

  //DELETE METHOD
  Future<int> delete(String table, String columnId, int id) async {
    final db = await instance?.streamDatabase;
    return db!.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }

  ProcessingQueueDao get processingQueueDao => ProcessingQueueDao(instance!);

  FeatureDao get featureDao => FeatureDao(instance!);

  ConfigDao get configDao => ConfigDao(instance!);

  void close() {
    _database = null;
    _streamDatabase!.close();
  }
}
