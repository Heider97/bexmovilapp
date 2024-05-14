part of '../app_database.dart';

class NavigationDao {
  final AppDatabase _appDatabase;

  NavigationDao(this._appDatabase);

  List<Navigation> parseNavigations(List<Map<String, dynamic>> navigationList) {
    final navigations = <Navigation>[];
    for (var navigationMap in navigationList) {
      final navigation = Navigation.fromJson(navigationMap);
      navigations.add(navigation);
    }
    return navigations;
  }

  Future<Navigation?> findNavigation(int id) async {
    final db = await _appDatabase.database;
    final navigationList = await db!
        .query(tableNavigations, where: 'id = ?', whereArgs: [id]);
    final navigation = parseNavigations(navigationList);
    if (navigation.isEmpty) {
      return null;
    }
    return navigation.first;
  }

  Future<void> emptyNavigations() async {
    final db = await _appDatabase.database;
    await db!.delete(tableNavigations, where: 'id > 0');
    return Future.value();
  }
}
