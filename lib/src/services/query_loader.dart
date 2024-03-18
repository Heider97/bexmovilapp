//domain
import '../domain/models/application.dart';
import '../domain/models/logic_query.dart';
import '../domain/models/raw_query.dart';
import '../domain/models/feature.dart';
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
  /// - [arguments] List of values to get result
  Future getResults(String moduleName, List<dynamic> arguments) async {
    var module = await databaseRepository.findModule(moduleName);
    if (module != null && module.id != null) {
      var sections = await databaseRepository.findSections(module.id!);
      if (sections != null && sections.isNotEmpty) {
        for (var section in sections) {
          var components = await databaseRepository.findComponents(section.id!);
          if (components != null && components.isNotEmpty) {
            section.components = components;
            for (var component in components) {
              Type? type;

              if(component.type == 'list') {
                type = List<Application>;
              } else if (component.type == 'feature'){
                type = List<Feature>;
              }

              var results =
                  await databaseRepository.logicQueries(component.id!);
              List<LogicQuery> logicQueries =
                  await dynamicListTypes['List<LogicQuery>']!.fromMap(results);
              if (logicQueries.isNotEmpty) {
                if (logicQueries.length == 1) {
                  var results = await determine(type, logicQueries.first, arguments);
                  component.results = results;
                } else {
                  for (var lq in logicQueries) {
                    if (lq.logicId != null) {
                      var logic =
                          await databaseRepository.findLogic(lq.logicId!);
                      if (logic != null) {
                        var result =
                            await databaseRepository.validateLogic(logic);
                        if (result == true) {
                          var results = await determine(type!, logicQueries.first, arguments);
                          component.results = results;
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }

        return sections;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  Future determine(
      Type? type, LogicQuery logicQuery, List<dynamic> arguments) async {
    if (logicQuery.queryType == 'query') {
      var q = await readQuery(logicQuery.queryId!);
      if (q != null && q.arguments != null) {
        return await executeQuery(type, q.table!, q.where, arguments);
      } else if(q != null) {
        return await executeQuery(type, q.table!, q.where, []);
      }
    } else if (logicQuery.queryType == 'raw_query') {
      var q = await readRawQuery(logicQuery.queryId!);
      if (q != null) {
        var sentence =
            replaceValues(q.sentence!, arguments, q.replaceAll ?? false);

        return await executeRawQuery(sentence, type);
      }
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

  Future<List<dynamic>> executeQuery(
      Type? type, String table, String? where, List<dynamic> arguments) async {
    if(type == null) return [];
    var results = await databaseRepository.query(table, where, arguments);
    return await dynamicListTypes[type.toString()]!.fromMap(results);
  }

  Future<List<dynamic>> executeRawQuery(String sentence, Type? type) async {
    if(type == null) return [];
    print(sentence);
    var results = await databaseRepository.rawQuery(sentence);
    print(results);
    return await dynamicListTypes[type.toString()]!.fromMap(results);
  }
}
