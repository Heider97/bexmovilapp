// //domain
// import '../domain/models/query.dart';
//
// //services
// import '../locator.dart';
// import '../domain/repositories/database_repository.dart';
//
// class QueryLoaderService {
//   static QueryLoaderService? _instance;
//   final databaseRepository = locator<DatabaseRepository>();
//
//   static Future<QueryLoaderService?> getInstance() async {
//     _instance ??= QueryLoaderService();
//     return _instance;
//   }
//
//
//   Future<List<dynamic>> getResults(type, module, component, arguments) async {
//
//
//     return [];
//   }
//
//   Future<List<Query>> readQuery(String module, String component, bool isSingle) async {
//     // return databaseRepository.findQuery(module, component);
//     return [];
//   }
//
//   Future<void> replaceValues(String query, String values) async {
//     var replaces = query.allMatches('?');
//
//     print(replaces);
//
//   }
//   Future<void> executeQuery() async {
//     //
//     //
//     // var r = parseClient(results);
//     return [];
//   }
// }
