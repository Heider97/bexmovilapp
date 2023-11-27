import 'package:bexmovil/src/domain/models/location.dart';
import 'package:bexmovil/src/domain/models/processing_queue.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:path/path.dart' as path;
import 'package:sqlbrite/sqlbrite.dart';

SharedPreferences? _preferences;

class DatabaseHelper {
  Future<Database?> getDataBase({int? version, List<String>? migrations}) async {
    _preferences ??= await SharedPreferences.getInstance();
    return await openDatabase(
      path.join(
          await getDatabasesPath(), '${_preferences!.getString('te')}.db'),
      /*   await getDatabasesPath(),
          'test.db'), */
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

/*    WorkDao get workDao => WorkDao(getDataBase);
   */
}
