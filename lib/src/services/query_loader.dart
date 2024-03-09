//domain
import 'package:bexmovil/src/utils/extensions/string_extension.dart';

import '../domain/models/query.dart';

//services
import '../locator.dart';
import '../domain/repositories/database_repository.dart';

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
  Future<List<dynamic>> getResults(Type type, String module, String component,
      arguments, bool isSingle) async {
    return [];
  }

  Future<List<Query>> readQuery(
      String module, String component, bool isSingle) async {
    // return databaseRepository.findQuery(module, component);
    return [];
  }

  Future<void> replaceValues(String query, List<dynamic> values) async {
    query = '''
    SELECT
    tdr.diarutero, tdr.nomdiarutero, c.nomcliente,
    tr.diarutero, c.dircliente, c.nitcliente, c.succliente,
    c.email, c.telcliente, c.codprecio, c.cupo,
    c.codfpagovta, c.razcliente,
    SUM(tc.preciomov) as wallet,
    c.latitud, c.longitud
    FROM tblmrutero tr, tblmdiarutero tdr, tblmcliente c, tbldcartera tc
    WHERE tr.diarutero = tdr.diarutero AND tr.codcliente = c.codcliente
    AND tc.codcliente = tr.codcliente
    AND tdr.DIARUTERO = '?' AND tr.CODVENDEDOR = '?' GROUP BY tr.CODCLIENTE
    ''';

    values = ['001', '09'];

    var replaces = findWord(query, '?');

    var index = 0;
    for(var replace in replaces) {
      if(values[index] != null) {
        query = query.replaceCharAt(query, replace, values[index]);
      }
      index++;
    }

    print(query);

  }

  List<int> findWord(String textString, String word) {
    List<int> indexes = <int>[];
    String lowerCaseTextString = textString.toLowerCase();
    String lowerCaseWord = word.toLowerCase();

    print(textString);

    int index = 0;
    while(index != -1){
      index = lowerCaseTextString.indexOf(lowerCaseWord, index);
      print(index);
      if (index != -1) {
        indexes.add(index);
        index++;
      }
    }
    return indexes;
  }

  Future<void> executeQuery(String query) async {

    // var results = databaseRepository.query()
    //
    //
    // var r = parseClient(results);
    // return [];
  }
}
