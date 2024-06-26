import 'dart:convert';
import 'package:flutter/material.dart' as material;


import 'package:bexmovil/src/data/datasources/local/dao/shopping_cart_dao.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqlbrite/sqlbrite.dart';
import 'package:synchronized/synchronized.dart';

// [UTILS]
import '../../../utils/constants/strings.dart';

// [MODELS]
/// [CORE]
import '../../../domain/models/module.dart';
import '../../../domain/models/view.dart';
import '../../../domain/models/bloc.dart';
import '../../../domain/models/bloc_event.dart';
import '../../../domain/models/section.dart';
import '../../../domain/models/widget.dart';
import '../../../domain/models/component.dart';
import '../../../domain/models/logic.dart';
import '../../../domain/models/logic_query.dart';
import '../../../domain/models/query.dart' as q;
import '../../../domain/models/raw_query.dart';
import '../../../domain/models/navigation.dart';

/// [FUNDAMENTAL]
import '../../../domain/models/location.dart';
import '../../../domain/models/processing_queue.dart';
import '../../../domain/models/config.dart';

/// [APP]
import '../../../domain/models/router.dart';
import '../../../domain/models/application.dart';
import '../../../domain/models/feature.dart';
import '../../../domain/models/client.dart';
import '../../../domain/models/error.dart';
import '../../../domain/models/filter.dart';
import '../../../domain/models/option.dart';
import '../../../domain/models/invoice.dart';

/// [ABSTRACTS]
import '../../../domain/abstracts/format_abstract.dart';

// [SERVICES]
import '../../../locator.dart';
import '../../../services/storage.dart';
import '../../../utils/extensions/inser_bulk_extension.dart';

// [MIGRATIONS]
part 'migrations/index.dart';

// [DAOS]
// [CORE]
part '../local/dao/module_dao.dart';
part '../local/dao/view_dao.dart';
part '../local/dao/bloc_dao.dart';
part '../local/dao/bloc_event_dao.dart';
part '../local/dao/section_dao.dart';
part '../local/dao/widget_dao.dart';
part '../local/dao/component_dao.dart';
part '../local/dao/logic_dao.dart';
part '../local/dao/query_dao.dart';
part '../local/dao/raw_query_dao.dart';
part '../local/dao/navigation_dao.dart';
// [FUNDAMENTAL]
part '../local/dao/location_dao.dart';
part '../local/dao/config_dao.dart';
part '../local/dao/processing_queue_dao.dart';
// [APP]
part '../local/dao/feature_dao.dart';
part '../local/dao/client_dao.dart';
part '../local/dao/routers_dao.dart';
part '../local/dao/application_dao.dart';
part '../local/dao/error_dao.dart';
part '../local/dao/filter_dao.dart';
part '../local/dao/option_dao.dart';

final LocalStorageService _storageService = locator<LocalStorageService>();

class AppDatabase {
  static BriteDatabase? _streamDatabase;

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
        onUpgrade: (db, oldVersion, newVersion) async {});
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

  //SCRIPTING
  Future<void> runMigrations(List<String> migrations) async {
    final db = await instance.streamDatabase;
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
    final db = await instance.streamDatabase;
    var result = await db!.rawQuery('SELECT changes($table)');
    return result.isNotEmpty;
  }

  Future<List<Map<String, Object?>>> logicQueries(int componentId) async {
    final db = await instance.streamDatabase;
    final results = await db!.rawQuery('''
    SELECT * FROM $tableLogicsQueries 
    WHERE ${LogicQueryFields.componentId} = $componentId
    ''');
    return results;
  }

  Future<List<Map<String, Object?>>> query(
      String query, String? where, List<dynamic>? values) async {
    final db = await instance.streamDatabase;
    return await db!.query(query, where: where, whereArgs: values);
  }

  Future<Map<String, Object?>> querySingle(
      String query, String? where, List<dynamic>? values) async {
    final db = await instance.streamDatabase;
    final results = await db!.query(query, where: where, whereArgs: values);
    return results.first;
  }

  Future<List<Map<String, Object?>>> rawQuery(String sentence) async {
    final db = await instance.streamDatabase;
    return await db!.rawQuery(sentence);
  }

  Future<Map<String, Object?>> rawQuerySingle(String sentence) async {
    final db = await instance.streamDatabase;
    final results = await db!.rawQuery(sentence);
    return results.first;
  }

  Future<List<Map<String, Object?>>> search(String table) async {
    final db = await instance.streamDatabase;
    return await db!.query(table);
  }

  Future<void> emptyAllTablesToSync() async {
    final db = await instance.streamDatabase;

    // Get a list of all tables in the database
    List<Map<String, dynamic>> tables = await db!.rawQuery('''
      SELECT name FROM sqlite_master 
      WHERE type='table' AND name NOT LIKE 'sqlite_%'
      AND name NOT IN (
        'android_metadata',
        'app_features',
        'app_funcionalities',
        'app_route_transaction',
        'configs',
        'error_logs',
        'features',
        'filters',
        'locations',
        'options',
        'polylines',
        'processing_queues',
        'sqlite_sequence',
        'app_cart_stock',
        'app_cart'

      )
    ''');

    // Iterate over each table and delete all records
    for (Map<String, dynamic> table in tables) {
      await db.delete(table['name'], where: '1');
    }
  }

  Future<void> emptyAllTables() async {
    final db = await instance.streamDatabase;

    // Get a list of all tables in the database
    List<Map<String, dynamic>> tables = await db!.rawQuery('''
      SELECT name FROM sqlite_master 
      WHERE type='table' AND name NOT LIKE 'sqlite_%'
    ''');

    // Iterate over each table and delete all records
    for (Map<String, dynamic> table in tables) {
      await db.delete(table['name'], where: '1');
    }
  }

  //INSERT METHOD
  Future<int> insert(String table, Map<String, dynamic> row) async {
    final db = await instance.database;
    return db!.insert(table, row);
  }

  Future<List<int>?> insertAll(String table, List<dynamic> objects) async {
    final db = await instance.database;
    if (objects.isEmpty) return null;
    var results = <int>[];
    try {
      Iterable<Map<String, Object?>> iterableMap = objects.map((item) {
        if (item is Map<String, dynamic>) {
          return item;
        } else {
          return {};
        }
      });

      var result = await db!.insertMultiple(table, iterableMap,
          conflictAlgorithm: ConflictAlgorithm.ignore, blockSize: 500);
      if (result != null) {
        results.add(result);
      }

      // await db?.transaction((tnx) async {
      //   final batch = tnx.batch();
      //   for (var object in objects) {
      //     batch.insert(table, object);
      //   }
      //   await batch.commit(continueOnError: true, noResult: true);
      // });

      return results;
    } catch (er) {
      return null;
    }
  }

  //UPDATE METHOD
  Future<int> update(
      String table, Map<String, dynamic> value, String columnId, int id) async {
    final db = await instance.streamDatabase;
    return db!.update(table, value, where: '$columnId = ?', whereArgs: [id]);
  }

  //DELETE METHOD
  Future<int> delete(String table, String columnId, int id) async {
    final db = await instance.streamDatabase;
    return db!.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }

  ViewDao get viewDao => ViewDao(instance);

  BlocDao get blocDao => BlocDao(instance);

  BlocEventDao get blocEventDao => BlocEventDao(instance);

  ModuleDao get moduleDao => ModuleDao(instance);

  SectionDao get sectionDao => SectionDao(instance);

  WidgetDao get widgetDao => WidgetDao(instance);

  ComponentDao get componentDao => ComponentDao(instance);

  LogicDao get logicDao => LogicDao(instance);

  QueryDao get queryDao => QueryDao(instance);

  RawQueryDao get rawQueryDao => RawQueryDao(instance);

  NavigationDao get navigationDao => NavigationDao(instance);

  ProcessingQueueDao get processingQueueDao => ProcessingQueueDao(instance);

  FeatureDao get featureDao => FeatureDao(instance);

  ConfigDao get configDao => ConfigDao(instance);

  ClientDao get clientDao => ClientDao(instance);

  RouterDao get routerDao => RouterDao(instance);

  ApplicationDao get applicationDao => ApplicationDao(instance);

  LocationDao get locationDao => LocationDao(instance);

  FilterDao get filterDao => FilterDao(instance);

  OptionDao get optionDao => OptionDao(instance);

  ErrorDao get errorDao => ErrorDao(instance);

  ShoppingCartDao get shoppingCartDao => ShoppingCartDao(instance);

  void close() {
    _database!.close();
    _database = null;
  }
}
