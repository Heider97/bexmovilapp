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

  List<Invoice> parseInvoices(List<Map<String, dynamic>> invoiceList) {
    final invoices = <Invoice>[];
    for (var invoiceMap in invoiceList) {
      final invoice = Invoice.fromJson(invoiceMap);
      invoices.add(invoice);
    }
    return invoices;
  }

  Future<List<Client>> getAllClients() async {
    final db = await _appDatabase.database;
    final clientList = await db!.query(tableClients);
    final clients = parseClients(clientList);
    return clients;
  }

  Future<List<Client>> getAllClientsRouter(
      String seller, String dayRouter) async {
    final db = await _appDatabase.database;
/*     final clientsRouterList = await db!.rawQuery('''
      SELECT tdr.diarutero, tdr.nomdiarutero, c.nomcliente, tr.diarutero, 
      c.dircliente, c.nitcliente, c.succliente, c.email, c.telcliente, 
      c.codprecio, c.cupo, c.codfpagovta, c.razcliente, SUM(tc.preciomov) as wallet,
      c.latitud, c.longitud
      FROM tblmrutero tr, tblmdiarutero tdr, tblmcliente c, tbldcartera tc
      WHERE tr.diarutero = tdr.diarutero AND tr.codcliente = c.codcliente
      AND tc.codcliente = tr.codcliente
      AND tdr.DIARUTERO = '$dayRouter' AND tr.CODVENDEDOR = '$seller' 
      GROUP BY tr.CODCLIENTE
    '''); */
    final clientsRouterList = await db!.rawQuery('''
       SELECT 
    tdr.diarutero, 
    tdr.nomdiarutero, 
    c.nomcliente, 
    tr.diarutero, 
    c.dircliente, 
    c.nitcliente, 
    c.succliente, 
    c.email, 
    c.telcliente, 
    c.codprecio, 
    c.cupo, 
    c.codfpagovta, 
    c.razcliente, 
    SUM(tc.preciomov) as wallet,
    c.latitud as cliente_latitud, -- Latitud del cliente
    c.longitud as cliente_longitud, -- Longitud del cliente
    l.latitud as latitud, -- Latitud de la ubicación
    l.longitud as longitud -- Longitud de la ubicación
FROM 
    tblmrutero tr, 
    tblmdiarutero tdr, 
    tblmcliente c, 
    tbldcartera tc
JOIN 
    tbldclilatlon l -- Tabla de ubicaciones
ON 
    c.codcliente = l.codcliente -- Unir las tablas por el código de cliente
WHERE 
    tr.diarutero = tdr.diarutero 
    AND tr.codcliente = c.codcliente 
    AND tc.codcliente = tr.codcliente 
    AND tdr.DIARUTERO = '$dayRouter' 
    AND tr.CODVENDEDOR = '$seller' 
GROUP BY 
    tr.CODCLIENTE;
    ''');

    final clientRouters = parseClients(clientsRouterList);
    return clientRouters;
  }

  Future<List<Client>> getClient(String codeClient) async {
    final db = await _appDatabase.database;
    final routerList = await db!
        .query(tableClients, where: 'NITCLIENTE = ?', whereArgs: [codeClient]);
    final routers = parseClients(routerList);
    return routers;
  }

  Future<List<Client>> getClientInformationByAgeRange(
      String range, String seller) async {
    final db = _appDatabase._database;

    var query = '''
    SELECT t.codcliente, t.NOMCLIENTE, COUNT(t.nummov) AS total,
    SUM(t.preciomov) AS wallet
    FROM (
    SELECT DISTINCT f.codcliente,
        tblmcliente.nomcliente,
        tbldcartera.nummov,
        tbldcartera.codtipodoc,
        tbldcartera.preciomov
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
        ?
    ) as t
    GROUP BY t.NOMCLIENTE, t.codtipodoc
    ''';

    switch (range) {
      case 'SV':
        query = query.replaceAll('?', '''
         AND STRFTIME("%Y-%m-%d", tbldcartera.fecmov) > STRFTIME("%Y-%m-%d", datetime('now', '-1 days'))
        ''');
        break;
      case '0-30':
        query = query.replaceAll('?', '''
        AND STRFTIME("%Y-%m-%d", tbldcartera.fecmov) between 
        STRFTIME("%Y-%m-%d", datetime('now', '-30 days'))
        and STRFTIME("%Y-%m-%d", datetime('now', '-1 days'))
        ''');
        break;
      case '31-60':
        query = query.replaceAll('?', '''
        AND STRFTIME("%Y-%m-%d", tbldcartera.fecmov) between 
        STRFTIME("%Y-%m-%d", datetime('now', '-60 days'))
        and STRFTIME("%Y-%m-%d", datetime('now', '-31 days'))
        ''');
        break;
      case '61-90':
        query = query.replaceAll('?', '''
        AND STRFTIME("%Y-%m-%d", tbldcartera.fecmov) between 
        STRFTIME("%Y-%m-%d", datetime('now', '-90 days'))
        and STRFTIME("%Y-%m-%d", datetime('now', '-61 days'))
        ''');
        break;
      case '+90':
        query = query.replaceAll('?', '''
        AND STRFTIME("%Y-%m-%d", tbldcartera.fecmov) < STRFTIME("%Y-%m-%d", datetime('now', '-90 days'))
        ''');
        break;
    }

    var results = await db!.rawQuery(query);

    List<Client> clients = parseClients(results);
    return clients;
  }

  Future<List<Invoice>> getInvoicesByClient(
      String range, String seller, String client) async {
    final db = _appDatabase._database;

    var query = '''
    SELECT t.codcliente, 
    t.nummov,
    CASE t.fecven WHEN STRFTIME("%Y-%m-%d", t.fecven) > STRFTIME("%Y-%m-%d", datetime('now', '-1 days')) THEN 'Al día' ELSE 'Mora' END AS fecven,
    t.preciomov
    FROM (
    SELECT DISTINCT f.codcliente,
        tbldcartera.codtipodoc,
        tblmcliente.nomcliente,
        tbldcartera.nummov,
        tbldcartera.fecmov,
        tbldcartera.fecven,
        tbldcartera.preciomov
        FROM tbldcartera,tblmcliente, tblmvendedor,
        (
            SELECT tblmrutero.codcliente,tblmcliente.nitcliente
           FROM tblmrutero,tblmcliente
           WHERE tblmrutero.codvendedor = '$seller'
           AND tblmrutero.codcliente = tblmcliente.codcliente
           GROUP BY tblmrutero.codcliente
        ) as f
        WHERE tbldcartera.codcliente = tblmcliente.codcliente
        AND f.nitcliente = tblmcliente.nitcliente
        AND tbldcartera.codvendedor = tblmvendedor.codvendedor
        AND f.codcliente = "$client"
        ?
    ) as t
    ''';

    switch (range) {
      case 'SV':
        query = query.replaceAll('?', '''
         AND STRFTIME("%Y-%m-%d", tbldcartera.fecmov) > STRFTIME("%Y-%m-%d", datetime('now', '-1 days'))
        ''');
        break;
      case '0-30':
        query = query.replaceAll('?', '''
        AND STRFTIME("%Y-%m-%d", tbldcartera.fecmov) between 
        STRFTIME("%Y-%m-%d", datetime('now', '-30 days'))
        and STRFTIME("%Y-%m-%d", datetime('now', '-1 days'))
        ''');
        break;
      case '31-60':
        query = query.replaceAll('?', '''
        AND STRFTIME("%Y-%m-%d", tbldcartera.fecmov) between 
        STRFTIME("%Y-%m-%d", datetime('now', '-60 days'))
        and STRFTIME("%Y-%m-%d", datetime('now', '-31 days'))
        ''');
        break;
      case '61-90':
        query = query.replaceAll('?', '''
        AND STRFTIME("%Y-%m-%d", tbldcartera.fecmov) between 
        STRFTIME("%Y-%m-%d", datetime('now', '-90 days'))
        and STRFTIME("%Y-%m-%d", datetime('now', '-61 days'))
        ''');
        break;
      case '+90':
        query = query.replaceAll('?', '''
        AND STRFTIME("%Y-%m-%d", tbldcartera.fecmov) < STRFTIME("%Y-%m-%d", datetime('now', '-90 days'))
        ''');
        break;
    }
    var results = await db!.rawQuery(query);

    List<Invoice> invoices = parseInvoices(results);
    return invoices;
  }

  Stream<List<Client>> watchAllClients() async* {
    final db = await _appDatabase.database;
    final clientList = await db!.query(tableClients);
    final clients = parseClients(clientList);
    yield clients;
  }

  Future<int> insertClient(Client client) {
    return _appDatabase.insert(tableClients, client.toJson());
  }

  Future<int> updateClient(Client client) {
    return _appDatabase.update(
        tableClients, client.toJson(), 'NITCLIENTE', int.parse(client.nit!));
  }

  Future<void> emptyClients() async {
    final db = _appDatabase._database;
    db!.delete(tableClients);
    return Future.value();
  }
}
