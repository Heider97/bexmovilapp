part of '../app_database.dart';

class GraphicDao {
  final AppDatabase _appDatabase;

  GraphicDao(this._appDatabase);

  List<Graphic> parseGraphics(List<Map<String, dynamic>> graphicList) {
    final graphics = <Graphic>[];
    for (var graphicMap in graphicList) {
      final graphic = Graphic.fromJson(graphicMap);
      graphics.add(graphic);
    }
    return graphics;
  }

  Future<List<Graphic>> getAllGraphics() async {
    final db = _appDatabase._database;
    final graphicList = await db!.query(tableGraphics, orderBy: '_order DESC');
    final graphics = parseGraphics(graphicList);
    return graphics;
  }

  Future<void> insertGraphics(List<Graphic> graphics) async {
    final db = _appDatabase._database;
    var batch = db!.batch();

    await Future.forEach(graphics, (app) async {
      var foundApp = await db.query(tableGraphics, where: 'id = ?', whereArgs: [app.id]);

      if(foundApp.isNotEmpty){
        batch.update(tableGraphics, app.toJson(), where: 'id = ?', whereArgs: [app.id]);
      } else {
        batch.insert(tableGraphics, app.toJson());
      }
    });


    batch.commit(noResult: true, continueOnError: true);
  }

  Future<int> insertGraphic(Graphic graphic) {
    return _appDatabase.insert(tableGraphics, graphic.toJson());
  }

  Future<int> updateGraphic(Graphic graphic) {
    return _appDatabase.update(tableGraphics, graphic.toJson(), 'id', graphic.id!);
  }

  Future<void> emptyGraphics() async {
    final db = _appDatabase._database;
    db!.delete(tableGraphics);
    return Future.value();
  }
}
