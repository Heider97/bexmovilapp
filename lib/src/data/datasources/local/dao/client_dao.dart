part of '../app_database.dart';

class ClientDao {
  final AppDatabase _appDatabase;

  ClientDao(this._appDatabase);

  List<Client> parseClients(List<Map<String, dynamic>> clientList) {
    final clients = <Client>[];
    for (var clientMap in clientList) {
      final client = Client.fromJson(clientMap);
      clients.add(client);
    }
    return clients;
  }

  Future<List<Client>> getAllClients() async {
    final db =  await _appDatabase.database;
    final clientList = await db!.query('tblmcliente');
    final clients = parseClients(clientList);
    return clients;
  }

  Future<List<Client>> getAllClientsRouter(
      String seller, String dayRouter) async {
    final db = await _appDatabase.database;


    final clientsRouterList = await db!.rawQuery('''
        SELECT tdr.NOMDIARUTERO, c.razcliente AS NOMCLIENTE, tr.diarutero, c.DIRCLIENTE, c.NITCLIENTE, c.SUCCLIENTE, c.EMAIL
         FROM tblmrutero tr, tblmdiarutero tdr, tblmcliente c
         WHERE tr.diarutero = tdr.diarutero AND tr.codcliente = c.codcliente 
         AND tdr.NOMDIARUTERO = '$dayRouter' AND tr.CODVENDEDOR = "$seller" 
         GROUP BY tr.CODCLIENTE
    ''');
    final clientRouters = parseClients(clientsRouterList);
    return clientRouters;
  }

  Stream<List<Client>> watchAllClients() async* {
    final db =  await _appDatabase.database;
    final clientList = await db!.query('tblmcliente');
    final clients = parseClients(clientList);
    yield clients;
  }

  Future<int> insertClient(Client client) {
    return _appDatabase.insert('tblmcliente', client.toJson());
  }

  Future<int> updateClient(Client client) {
    return _appDatabase.update('tblmcliente', client.toJson(), 'NITCLIENTE',
        int.parse(client.nitCliente!));
  }

  Future<void> emptyClients() async {
    final db =  _appDatabase._database;
     db!.delete('tblmcliente');
    return Future.value();
  }
}
