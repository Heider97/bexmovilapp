//domain
import 'package:bexmovil/src/domain/models/raw_query.dart';

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
  Future getResults(
      Type type, String moduleName, List<dynamic> arguments) async {
    var module = await databaseRepository.findModule(moduleName);
    if (module != null && module.id != null) {
      var sections = await databaseRepository.findSections(module.id!);
      if (sections != null && sections.isNotEmpty) {
        for (var section in sections) {
          var components = await databaseRepository.findComponents(section.id!);
          if (components != null && components.isNotEmpty) {
            for (var component in components) {

              var queries = await databaseRepository.rawQuery('''
                SELECT * FROM 
              ''');


              Query? query;
              if (component.logicQueryId != null) {
                //TODO: [Heider Zapa] do logic to execute conditions
              } else {
                query = await readQuery(4);
              }

              if (query != null) {}
            }
          }
        }
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  Future<Query?> readQuery(int id) async {
    return databaseRepository.findQuery(id);
  }

  Future<RawQuery?> readRawQuery(int id) async {
    return databaseRepository.findRawQuery(id);
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

  Future<List<dynamic>> executeQuery(Type type, String table, String queryType,
      String? where, List<dynamic> arguments) async {
    var results = await databaseRepository.query(table, where, arguments);
    return await dynamicListTypes[type.toString()]!.fromMap(results);
  }

  Future<List<dynamic>> executeRawQuery(String sentence, Type type) async {
    var results = await databaseRepository.rawQuery(sentence);
    return await dynamicListTypes[type.toString()]!.fromMap(results);
  }
}
