part of '../app_database.dart';

class SectionDao {
  final AppDatabase _appDatabase;

  SectionDao(this._appDatabase);

  List<Section> parseSections(List<Map<String, dynamic>> sectionList) {
    final sectons = <Section>[];
    for (var sectionMap in sectionList) {
      final section = Section.fromJson(sectionMap);
      sectons.add(section);
    }
    return sectons;
  }

  Future<Section?> findSection(String name, int moduleId) async {
    final db = await _appDatabase.database;
    var sectionList = await db!.query(tableSections,
        where: 'name = ? and module_id = ?', whereArgs: [name, moduleId]);
    var sectons = parseSections(sectionList);
    if (sectons.isNotEmpty) {
      return sectons.first;
    }
    return null;
  }

  Future<void> insertSections(List<Section> sectons) async {
    final db = await _appDatabase.database;
    var batch = db!.batch();

    await Future.forEach(sectons, (section) async {
      var foundProduct = await db
          .query(tableSections, where: 'name = ?', whereArgs: [section.name]);

      if (foundProduct.isNotEmpty) {
        batch.update(tableSections, section.toJson(),
            where: 'name = ?', whereArgs: [section.name]);
      } else {
        batch.insert(tableSections, section.toJson());
      }
    });

    batch.commit(noResult: true, continueOnError: true);
  }

  Future<void> emptySections() async {
    final db = await _appDatabase.database;
    await db!.delete(tableSections);
    return Future.value();
  }
}
