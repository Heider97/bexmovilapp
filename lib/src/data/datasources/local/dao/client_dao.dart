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

  getClientInformation() async {
    final db = _appDatabase._database;
    await db!.rawQuery('''SELECT DISTINCT f.codcliente,
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
		WHERE tblmrutero.codvendedor = '?'
		AND tblmrutero.codcliente = tblmcliente.codcliente
		GROUP BY codcliente
	) as f
	WHERE tbldcartera.codcliente=tblmcliente.codcliente
	AND f.nitcliente = tblmcliente.nitcliente
	AND tbldcartera.codvendedor = tblmvendedor.codvendedor
	AND DATE(tbldcartera.FECMOV) <= DATE_FORMAT(NOW() - INTERVAL 31 DAY, "%Y-%m-%d")
    AND DATE(tbldcartera.FECMOV) >= DATE_FORMAT(NOW() - INTERVAL 60 DAY, "%Y-%m-%d")
  }''');
  }
}
