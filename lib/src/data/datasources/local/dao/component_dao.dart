part of '../app_database.dart';

class ComponentDao {
  final AppDatabase _appDatabase;

  ComponentDao(this._appDatabase);

  List<Component> parseComponents(List<Map<String, dynamic>> componentList) {
    final components = <Component>[];
    for (var componentMap in componentList) {
      final component = Component.fromJson(componentMap);
      components.add(component);
    }
    return components;
  }

  Future<List<Component>?> findComponents(int sectionId) async {
    final db = await _appDatabase.database;
    var componentList = await db!.query(tableComponents,
        where: 'id = ?', whereArgs: [sectionId]);
    var components = parseComponents(componentList);
    return components;
  }

  Future<void> insertComponents(List<Component> components) async {
    final db = await _appDatabase.database;
    var batch = db!.batch();

    await Future.forEach(components, (component) async {
      var foundProduct = await db.query(tableComponents,
          where: 'title = ?', whereArgs: [component.title]);

      if (foundProduct.isNotEmpty) {
        batch.update(tableComponents, component.toJson(),
            where: 'title = ?', whereArgs: [component.title]);
      } else {
        batch.insert(tableComponents, component.toJson());
      }
    });

    batch.commit(noResult: true, continueOnError: true);
  }

  Future<void> emptyComponents() async {
    final db = await _appDatabase.database;
    await db!.delete(tableComponents);
    return Future.value();
  }
}
