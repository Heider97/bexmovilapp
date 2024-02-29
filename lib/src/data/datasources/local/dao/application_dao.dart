part of '../app_database.dart';

class ApplicationDao {
  final AppDatabase _appDatabase;

  ApplicationDao(this._appDatabase);

  List<Application> parseApplications(List<Map<String, dynamic>> applicationList) {
    final applications = <Application>[];
    for (var applicationMap in applicationList) {
      final application = Application.fromJson(applicationMap);
      applications.add(application);
    }
    return applications;
  }

  Future<List<Application>> getAllApplications() async {
    final db = _appDatabase._database;
    final applicationList = await db!.query(tableApplications, where: 'enabled = ?', whereArgs: [1]);
    final applications = parseApplications(applicationList);
    return applications;
  }

  Future<void> insertApplications(List<Application> applications) async {
    final db = _appDatabase._database;
    var batch = db!.batch();

    await Future.forEach(applications, (app) async {
      var foundApp = await db.query(tableApplications, where: 'id = ?', whereArgs: [app.id]);

      if(foundApp.isNotEmpty){
        batch.update(tableApplications, app.toJson(), where: 'id = ?', whereArgs: [app.id]);
      } else {
        batch.insert(tableApplications, app.toJson());
      }
    });


    batch.commit(noResult: true, continueOnError: true);
  }

  Future<int> insertApplication(Application application) {
    return _appDatabase.insert(tableApplications, application.toJson());
  }

  Future<int> updateApplication(Application application) {
    return _appDatabase.update(tableApplications, application.toJson(), 'id', application.id!);
  }

  Future<void> emptyApplications() async {
    final db = _appDatabase._database;
    db!.delete('app_functionalities');
    return Future.value();
  }
}
