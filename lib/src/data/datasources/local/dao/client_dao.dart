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
    final db = await _appDatabase.database;
    final clientList = await db!.query('tblmcliente');
    final clients = parseClients(clientList);
    return clients;
  }

  Future<List<Client>> getAllClientsRouter(
      String seller, String dayRouter) async {
    final db = await _appDatabase.database;
    final clientsRouterList = await db!.rawQuery('''
<<<<<<< HEAD
        SELECT tdr.NOMDIARUTERO, c.NOMCLIENTE, tr.diarutero, c.DIRCLIENTE, c.NITCLIENTE, c.SUCCLIENTE, c.EMAIL, c.TELCLIENTE, c.CODPRECIO, c.CUPO, c.CODFPAGOVTA, c.RAZCLIENTE
         FROM tblmrutero tr, tblmdiarutero tdr, tblmcliente c
         WHERE tr.diarutero = tdr.diarutero AND tr.codcliente = c.codcliente 
         AND tdr.NOMDIARUTERO = '$dayRouter' AND tr.CODVENDEDOR = "$seller" 
         GROUP BY tr.CODCLIENTE
=======
      SELECT tdr.NOMDIARUTERO, c.razcliente, c.NOMCLIENTE, tr.diarutero, c.DIRCLIENTE, c.NITCLIENTE, c.SUCCLIENTE, c.EMAIL
      FROM tblmrutero tr, tblmdiarutero tdr, tblmcliente c
      WHERE tr.diarutero = tdr.diarutero
      AND tr.codcliente = c.codcliente
      AND tr.DIARUTERO = "$dayRouter" 
      AND tr.CODVENDEDOR = "$seller" 
      GROUP BY tr.CODCLIENTE
>>>>>>> f6c1904317fe26e741192873d670bfef5c677496
    ''');
    final clientRouters = parseClients(clientsRouterList);
    return clientRouters;
  }

  Future<List<Client>> getClient(String codeClient) async {
    final db = await _appDatabase.database;
    final routerList = await db!
<<<<<<< HEAD
        .query(tableClient, where: 'NITCLIENTE = ?', whereArgs: [codeClient]);
=======
        .query('tblmcliente', where: 'CODCLIENTE = ?', whereArgs: [codeClient]);
>>>>>>> f6c1904317fe26e741192873d670bfef5c677496
    final routers = parseClients(routerList);
    return routers;
  }

  Stream<List<Client>> watchAllClients() async* {
    final db = await _appDatabase.database;
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
    final db = _appDatabase._database;
    db!.delete('tblmcliente');
    return Future.value();
  }

  Future<List<Client>> getClientInformationByAgeRange(List<int> range) async {
    final db = _appDatabase._database;
    dynamic clientsQuery = await db!.rawQuery('''SELECT 
    t.nomcliente AS name,
    COUNT(t.nummov) AS overdueInvoices,
    SUM(t.preciomov) AS walletAmmount
FROM (
SELECT DISTINCT f.codcliente,
    tbldcartera.codtipodoc,
    tblmcliente.nomcliente,
    tbldcartera.nummov,
    tbldcartera.fecmov,
    tbldcartera.fecven,
    CASE tbldcartera.debcre WHEN 'C' THEN tbldcartera.preciomov * -1 ELSE tbldcartera.preciomov END AS preciomov,
    tbldcartera.debcre,
    tbldcartera.recprov,
    '' AS idfacturacion,
    tbldcartera.valtotcredito,
    tbldcartera.vlr_dscto_pp,
    tbldcartera.fecha_dscto_pp,
    tblmvendedor.codvendedor,
    '' AS planilla
    FROM tbldcartera,tblmcliente, tblmvendedor,
    (
        SELECT tblmrutero.codcliente,tblmcliente.nitcliente
       FROM tblmrutero,tblmcliente
       WHERE tblmrutero.codvendedor = '09'
       AND tblmrutero.codcliente = tblmcliente.codcliente
       GROUP BY tblmrutero.codcliente
    ) as f
    WHERE tbldcartera.codcliente = tblmcliente.codcliente
    AND f.nitcliente = tblmcliente.nitcliente
    AND tbldcartera.codvendedor = tblmvendedor.codvendedor
    AND STRFTIME("%Y-%m-%d", tbldcartera.FECMOV) <= STRFTIME("%Y-%m-%d", datetime('now', '-31 days'))
    AND STRFTIME("%Y-%m-%d", tbldcartera.FECMOV) >= STRFTIME("%Y-%m-%d", datetime('now', '-60 days'))) as t
  group by t.nomcliente, t.codtipodoc
''');

    //range test 31 - 60

    List<Client> clients = parseClients(clientsQuery);
    return clients;
  }
}
