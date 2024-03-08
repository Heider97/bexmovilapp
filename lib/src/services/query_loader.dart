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


  Future<List<dynamic>> getResults() async {
    return [];
  }

  Future<void> readQuery() async {}
  Future<void> replaceValues() async {}
  Future<void> executeQuery() async {}
}
