part of '../app_database.dart';

class SectionDao {
  final AppDatabase _appDatabase;

  SectionDao(this._appDatabase);

  List<Section> parseSections(List<Map<String, dynamic>> sectionList) {
    final sections = <Section>[];
    for (var sectionMap in sectionList) {
      final section = Section.fromJson(sectionMap);
      sections.add(section);
    }
    return sections;
  }

  Future<List<Section>?> findSections(int moduleId) async {
    final db = await _appDatabase.database;
    var sectionList = await db!.query(tableSections,
        where: 'module_id = ?', whereArgs: [moduleId]);
    var sections = parseSections(sectionList);
    return sections;
  }

  Future<void> emptySections() async {
    final db = await _appDatabase.database;
    await db!.delete(tableSections);
    return Future.value();
  }
}
