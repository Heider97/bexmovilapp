part of '../app_database.dart';

class SyncFeaturesDao {
  final AppDatabase _appDatabase;

  SyncFeaturesDao(this._appDatabase);

  List<Clients> parseClients(
    List<Map<String,dynamic>> clientsLists){
    final clients = <Clients>[];
      for(var clientsMap in clientsLists){
        final client = Clients.fromJson(clientsMap);
        clients.add(client); 
      }
      return clients;
  }

  Future<List<Clients>> getAllClients() async {
    final db = await _appDatabase.streamDatabase;
    final clientsList = await db!.query(tableClients);
    final clients = parseClients(clientsList);
    return clients;
  }

  Future<int> insertClients(Clients clients) {
    return _appDatabase.insert(tableClients, clients.toJson());
  }

  Future<int> updateClients(Clients clients) {
    return _appDatabase.update(tableClients, clients.toJson(),
        'coddashboard', clients.coddashboard);
  }

  Future<void> emptyClients() async {
    final db = await _appDatabase.streamDatabase;
    await db!.delete(tableClients);
    return Future.value();
  }



}