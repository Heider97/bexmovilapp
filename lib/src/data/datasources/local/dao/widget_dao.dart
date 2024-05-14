part of '../app_database.dart';

class WidgetDao {
  final AppDatabase _appDatabase;

  WidgetDao(this._appDatabase);

  List<Widget> parseWidgets(List<Map<String, dynamic>> widgetList) {
    final widgets = <Widget>[];
    for (var widgetMap in widgetList) {
      final widget = Widget.fromJson(widgetMap);
      widgets.add(widget);
    }
    return widgets;
  }

  Future<List<Widget>?> findWidgets(int sectionId) async {
    final db = await _appDatabase.database;
    var widgetList = await db!.query(tableWidgets,
        where: 'module_section_id = ?',
        whereArgs: [sectionId],
        groupBy: 'name');
    var widgets = parseWidgets(widgetList);
    return widgets;
  }

  Future<List<Widget>?> findWidgetsByBloc(int appBlocId) async {
    final db = await _appDatabase.database;
    var widgetList = await db!.query(tableWidgets,
        where: 'app_bloc_event_id = ?', whereArgs: [appBlocId], groupBy: 'name');
    var widgets = parseWidgets(widgetList);
    return widgets;
  }

  Future<void> insertWidgets(List<Widget> widgets) async {
    final db = await _appDatabase.database;
    var batch = db!.batch();

    await Future.forEach(widgets, (widget) async {
      var foundProduct = await db.query(tableWidgets,
          where: 'widget = ? and type = ?',
          whereArgs: [widget.name, widget.type]);

      if (foundProduct.isNotEmpty) {
        batch.update(tableWidgets, widget.toJson(),
            where: 'widget = ? and type = ?',
            whereArgs: [widget.name, widget.type]);
      } else {
        batch.insert(tableWidgets, widget.toJson());
      }
    });

    batch.commit(noResult: true, continueOnError: true);
  }

  Future<void> emptyWidgets() async {
    final db = await _appDatabase.database;
    await db!.delete(tableWidgets);
    return Future.value();
  }
}
