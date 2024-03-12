//domain
import '../domain/models/query.dart';
import '../domain/repositories/database_repository.dart';

//utils
import '../utils/extensions/string_extension.dart';
import '../utils/resources/app_dynamic_caster_type.dart';

//services
import '../locator.dart';

class QueryLoaderService {
  static QueryLoaderService? _instance;
  final databaseRepository = locator<DatabaseRepository>();

  static Future<QueryLoaderService?> getInstance() async {
    _instance ??= QueryLoaderService();
    return _instance;
  }

  /// The function [getResults] can be customized using the following properties:
  /// - [type] for the type of result
  /// - [module] name of module
  /// - [component] name of view
  /// - [arguments] List of values to get result
  /// - [isSingle] validate type of results [single, multiple]
  Future<List<dynamic>?> getResults(Type type, String moduleName,
      String componentName, List<dynamic> arguments, bool isSingle) async {
    var module = await databaseRepository.findModule(moduleName);
    if (module != null && module.id != null) {
        // var component =
        //     await databaseRepository.findComponent(componentName, module.id!);
        // if (component != null && component.id != null) {
        //   var query = await readQuery(component.id!, isSingle);
        //   if (query != null) {
        //     if (query.type == 'raw_query') {
        //       var queryName = replaceValues(
        //           query.name!, arguments, query.replaceAll ?? false);
        //       return executeQuery(
        //           type, queryName, query.type!, query.where, arguments);
        //     } else {
        //       return executeQuery(
        //           type, query.name!, query.type!, query.where, arguments);
        //     }
        //   } else {
        //     return null;
        //   }
        return null;
      } else {
        return null;
      }
  }

  Future<Query?> readQuery(int componentId, bool isSingle) async {
    // return databaseRepository.findQuery(componentId, isSingle);
    return null;
  }

  String replaceValues(String query, List<dynamic> values, bool deep) {
    if (deep) {
      for (var value in values) {
        if (value != null) {
          query = query.replaceAll(query, value);
        }
      }
    } else {
      for (var value in values) {
        if (value != null) {
          var replace = query.indexOf('?');
          query = query.replaceCharAt(query, replace, value);
        }
      }
    }

    return query;
  }

  List<int> findWord(String textString, String word) {
    List<int> indexes = <int>[];
    String lowerCaseTextString = textString.toLowerCase();
    String lowerCaseWord = word.toLowerCase();
    int index = 0;
    while (index != -1) {
      index = lowerCaseTextString.indexOf(lowerCaseWord, index);
      if (index != -1) {
        indexes.add(index);
        index++;
      }
    }
    return indexes;
  }

  Future<List<dynamic>> executeQuery(Type type, String query, String queryType,
      String? where, List<dynamic> arguments) async {
    // var results =
    //     await databaseRepository.query(query, queryType, where, arguments);

    // return await dynamicListTypes[type.toString()]!.fromMap(results);
    return [];
  }
}
