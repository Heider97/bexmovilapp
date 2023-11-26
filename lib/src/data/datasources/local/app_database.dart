import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite_migration/sqflite_migration.dart';
import 'package:sqlbrite/sqlbrite.dart';
import 'package:synchronized/synchronized.dart';

//utils
import '../../../domain/models/clients.dart';
import '../../../utils/constants/strings.dart';

//models
import '../../../domain/models/location.dart';
import '../../../domain/models/processing_queue.dart';


//services
import '../../../locator.dart';
import '../../../services/storage.dart';


//daos
part '../local/dao/location_dao.dart';
part '../local/dao/processing_queue_dao.dart';
part '../local/dao/sync_features_dao.dart';

final LocalStorageService _storageService = locator<LocalStorageService>();

class AppDatabase {
  static BriteDatabase? _streamDatabase;

  // make this a singleton class
  // ignore: sort_constructors_first
  AppDatabase._privateConstructor();
  static final AppDatabase instance = AppDatabase._privateConstructor();
  static var lock = Lock();

  static Database? _database;

  final initialScript = [
    '''
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
    ''',
    '''
      CREATE TABLE $tableProcessingQueues (
        ${ProcessingQueueFields.id} INTEGER PRIMARY KEY,
        ${ProcessingQueueFields.body} TEXT DEFAULT NULL,
        ${ProcessingQueueFields.task} TEXT DEFAULT NULL,
        ${ProcessingQueueFields.code} TEXT DEFAULT NULL,
        ${ProcessingQueueFields.error} TEXT DEFAULT NULL,
        ${ProcessingQueueFields.createdAt} TEXT DEFAULT NULL,
        ${ProcessingQueueFields.updatedAt} TEXT DEFAULT NULL
      )
    '''
  ];

  final migrations = [
    '''
      CREATE TABLE $tableFeature (
        ${FeaturesFields.coddashboard} INTEGER PRIMARY KEY,
        ${FeaturesFields.codvendedor} INTEGER DEFAULT NULL,
        ${FeaturesFields.description} TEXT DEFAULT NULL,
        ${FeaturesFields.urldesc} TEXT DEFAULT NULL,
        ${FeaturesFields.categoria} INTEGER DEFAULT NULL,
        ${FeaturesFields.codcliente} INTEGER DEFAULT NULL,
        ${FeaturesFields.fechaevento} TEXT DEFAULT NULL,
        ${FeaturesFields.fechafinevento} TEXT DEFAULT NULL,
        ${FeaturesFields.fecgra} TEXT DEFAULT NULL,
        ${FeaturesFields.requerido} TEXT DEFAULT NULL,
        ${FeaturesFields.createdById} INTEGER DEFAULT NULL,
        ${FeaturesFields.createdAt} TEXT DEFAULT NULL,
        ${FeaturesFields.updatedAt} TEXT DEFAULT NULL,
        ${FeaturesFields.deletedAt} TEXT DEFAULT NULL,
      )
    '''
  ];

   Future<Database> _initDatabase(databaseName) async {
    final documentsDirectory = await getApplicationDocumentsDirectory();

     final config = MigrationConfig(
        initializationScript: initialScript, migrationScripts: []);

    final path = join(documentsDirectory.path, databaseName);

     return await openDatabaseWithMigration(path, config);
  }

   Future<Database?> get database async {
    var dbName = _storageService.getString('company_name');

    if (_database != null) return _database;
    await lock.synchronized(() async {
      if (_database == null) {
        dbName ??= databaseName;
        _database = await _initDatabase('$dbName.db');
        _streamDatabase = BriteDatabase(_database!);
      }
    });
    return _database;
  }

  Future<BriteDatabase?> get streamDatabase async {
    await database;
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

  SyncFeaturesDao get syncfeaturesDao => SyncFeaturesDao(instance);

  void close() {
    _database = null;
    _streamDatabase!.close();
  }
}