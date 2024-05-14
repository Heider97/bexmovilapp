//domain
import 'dart:convert';

import '../domain/models/logic_query.dart';
import '../domain/models/navigation.dart';
import '../domain/models/raw_query.dart';
import '../domain/models/query.dart';
import '../domain/repositories/database_repository.dart';

//utils
import '../utils/extensions/string_extension.dart';
import '../utils/resources/app_dynamic_caster_type.dart';

//services
import '../locator.dart';
import 'navigation.dart';

class QueryLoaderService {
  static QueryLoaderService? _instance;
  final databaseRepository = locator<DatabaseRepository>();
  final navigationService = locator<NavigationService>();

  static Future<QueryLoaderService?> getInstance() async {
    _instance ??= QueryLoaderService();
    return _instance;
  }

  /// The function [getResults] can be customized using the following properties:
  /// - [type] for the type of result
  /// - [module] name of module
  /// - [arguments] List of values to get result
  Future getResults(
      String moduleName, String seller, List<dynamic> arguments) async {
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
              var components =
                  await databaseRepository.findComponents(widget.id!);
              if (components != null && components.isNotEmpty) {
                widget.components = components;

                for (var component in components) {
                  var needBeMapped = component.type == "kpi" ? true : false;

                  component.type == "line"
                      ? widget.type = "List<ChartData>"
                      : widget.type;

                  var results =
                      await databaseRepository.logicQueries(component.id!);

                  List<LogicQuery> logicQueries =
                      await dynamicListTypes['List<LogicQuery>']!
                          .fromMap(results);

                  if (logicQueries.isNotEmpty) {
                    if (logicQueries.length == 1) {
                      var results = await determine(
                          widget.type, logicQueries.first, seller, arguments);

                      component.results = results;
                    } else {
                      for (var lq in logicQueries) {
                        if (lq.logicId != null) {
                          var logic =
                              await databaseRepository.findLogic(lq.logicId!);
                          if (logic != null) {
                            var result = await databaseRepository.validateLogic(
                                logic, seller);
                            if (result == true) {
                              var results = await determine(
                                  widget.type!, lq, seller, arguments);
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

  Future<Map<String, dynamic>> load(String view, String bloc, String event,
      String seller, List<dynamic> arguments) async {
    Map<String, dynamic> results = {};

    final v = await databaseRepository.findView(view);
    final b = await databaseRepository.findBloc(bloc);
    final e = await databaseRepository.findBlocEvent(event);

    final widgets = await databaseRepository.findWidgetsByBloc(e!.id!);

    if (widgets != null && widgets.isNotEmpty) {
      for (var widget in widgets) {
        var components = await databaseRepository.findComponents(widget.id!);

        if (components != null && components.isNotEmpty) {

          var data = <Map<String, dynamic>>[];

          for (var component in components) {

            var logicables =
                await databaseRepository.logicQueries(component.id!);

            List<LogicQuery> logicQueries =
                await dynamicListTypes['List<LogicQuery>']!.fromMap(logicables);

            if (logicQueries.isNotEmpty) {
              if (logicQueries.length == 1) {
                var d = await determine(component.type ?? widget.type,
                    logicQueries.first, seller, arguments);

                print(d);

                if (component.type != null && d != null) {
                  print('added $d');
                  data.add(d.toJson());
                } else {
                  results[widget.name!] = d;
                }
              } else {
                for (var lq in logicQueries) {
                  if (lq.logicId != null) {
                    var logic = await databaseRepository.findLogic(lq.logicId!);
                    if (logic != null) {
                      var result =
                          await databaseRepository.validateLogic(logic, seller);
                      if (result == true) {
                        var d = await determine(component.type ?? widget.type!,
                            lq, seller, arguments);

                        print(d);

                        if (component.type != null && d != null) {
                          print('added $d');
                          data.add(d.toJson());
                        } else {
                          results[widget.name!] = d;
                        }
                      }
                    }
                  }
                }
              }
            }
          }

          if (data.isNotEmpty) {
            var dynamic = await dynamicListTypes[widget.type]?.fromMap(data);
            results[widget.name!] = dynamic;
          }
        }
      }
    }

    return results;
  }

  Future determine(String? type, LogicQuery logicQuery, String seller,
      List<dynamic> arguments) async {
    if (logicQuery.actionableType == 'query') {
      var q = await readQuery(logicQuery.actionableId!);
      if (q != null && q.arguments != null) {
        return await executeQuery(type, q.table!, q.where, arguments);
      } else if (q != null) {
        return await executeQuery(type, q.table!, q.where, []);
      }
    } else if (logicQuery.actionableType == 'raw_query') {
      var q = await readRawQuery(logicQuery.actionableId!);
      if (q != null) {
        if (q.arguments != null) {
          var arg = jsonDecode(q.arguments!);

          if (arg.keys.length == 1 && arg.containsKey("seller")) {
            arg['seller'] = seller;
            arguments = [seller];
          }
        }
        var sentence =
            replaceValues(q.sentence!, arguments, q.replaceAll ?? false);
        return await executeRawQuery(sentence, type);
      }
    } else if (logicQuery.actionableType == 'navigation') {
      final navigation = await readNavigation(logicQuery.actionableId!);
      if (navigation != null) {
        Map<String, dynamic> data = jsonDecode(navigation.arguments!);

        List<String> keys = data.keys.toList();

        for (int i = 0; i < arguments.length; i++) {
          if (i < keys.length) {
            data[keys[i]] = arguments[i];
          } else {
            break;
          }
        }

        navigation.argument =
            await dynamicDataTypes[navigation.type!]?.fromMap(data);

        return navigation;
      }
    }
  }

  Future<Query?> readQuery(int id) async {
    return databaseRepository.findQuery(id);
  }

  Future<RawQuery?> readRawQuery(int id) async {
    return databaseRepository.findRawQuery(id);
  }

  Future<Navigation?> readNavigation(int id) async {
    return databaseRepository.findNavigation(id);
  }

  String replaceValues(String query, List<dynamic> values, bool deep) {
    try {
      if (deep) {
        for (var value in values) {
          if (value != null) {
            query = query.replaceAll('?', value);
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
    } catch (e) {
      return query;
    }
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

  Future executeQuery(String? type, String table, String? where,
      List<dynamic> arguments) async {
    try {
      if (type == null) return [];

      var dynamic;

      if (type.contains('List')) {
        var results = await databaseRepository.query(table, where, arguments);
        dynamic = await dynamicListTypes[type]?.fromMap(results);
      } else {
        var results =
            await databaseRepository.querySingle(table, where, arguments);
        dynamic = await dynamicDataTypes[type]?.fromMap(results);
      }

      return dynamic;
    } catch (e) {
      return [];
    }
  }

  Future executeRawQuery(String sentence, String? type,
      {needBeMapped = false}) async {
    try {
      if (type == null) return [];

      var dynamic;

      if (type.contains('List')) {
        var results = await databaseRepository.rawQuery(sentence);
        dynamic = await dynamicListTypes[type]?.fromMap(results);
      } else {
        var results = await databaseRepository.rawQuerySingle(sentence);
        dynamic = await dynamicDataTypes[type]?.fromMap(results);
      }

      return dynamic;
    } catch (e) {
      return [];
    }
  }
}
