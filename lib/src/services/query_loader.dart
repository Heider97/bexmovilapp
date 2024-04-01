//domain
import '../domain/models/logic_query.dart';
import '../domain/models/raw_query.dart';
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
    // FIND CURRENT MODULE
    var module = await databaseRepository.findModule(moduleName);
    if (module != null && module.id != null) {
      var sections = await databaseRepository.findSections(module.id!);
      if (sections != null && sections.isNotEmpty) {
        for (var section in sections) {
          var widgets = await databaseRepository.findWidgets(section.id!);
          if (widgets != null && widgets.isNotEmpty) {
            section.widgets = widgets;
            for (var widget in widgets) {
              print(widget.toJson());
              var components =
                  await databaseRepository.findComponents(widget.id!);
              if (components != null && components.isNotEmpty) {
                widget.components = components;
                for (var component in components) {

                  print(component.toJson());

                  var results =
                      await databaseRepository.logicQueries(component.id!);

                  List<LogicQuery> logicQueries =
                      await dynamicListTypes['List<LogicQuery>']!
                          .fromMap(results);

                  if (logicQueries.isNotEmpty) {
                    if (logicQueries.length == 1) {
                      var results = await determine(
                          widget.type, logicQueries.first, arguments);
                      component.results = results;
                    } else {
                      for (var lq in logicQueries) {
                        if (lq.logicId != null) {
                          var logic =
                              await databaseRepository.findLogic(lq.logicId!);
                          if (logic != null) {
                            print(logic.toJson());
                            var result =
                                await databaseRepository.validateLogic(logic);

                            print(result);
                            if (result == true) {
                              var results = await determine(
                                  widget.type!, logicQueries.first, arguments);
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
          } else {
            return null;
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
      String? type, LogicQuery logicQuery, List<dynamic> arguments) async {
    if (logicQuery.queryType == 'query') {
      var q = await readQuery(logicQuery.queryId!);
      if (q != null && q.arguments != null) {
        return await executeQuery(type, q.table!, q.where, arguments);
      } else if (q != null) {
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

  Future<List<dynamic>> executeQuery(String? type, String table, String? where,
      List<dynamic> arguments) async {
    if (type == null) return [];
    var results = await databaseRepository.query(table, where, arguments);
    var dynamic = await dynamicListTypes[type]?.fromMap(results);
    if (dynamic == null) {
      return [];
    }
    return dynamic;
  }

  Future<List<dynamic>> executeRawQuery(String sentence, String? type) async {
    if (type == null) return [];
    var results = await databaseRepository.rawQuery(sentence);
    var dynamic = await dynamicListTypes[type]?.fromMap(results);
    if (dynamic == null) {
      return [];
    }
    return dynamic;
  }
}
