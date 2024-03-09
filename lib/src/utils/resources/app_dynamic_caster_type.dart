//domain
import '../../domain/models/config.dart';
import '../../domain/models/router.dart';
import '../../domain/models/client.dart';
import '../../domain/models/invoice.dart';

List<Router> parseRouters(List<Map<String, dynamic>> routerList) {
  final routers = <Router>[];
  for (var routerMap in routerList) {
    final router = Router.fromJson(routerMap);
    routers.add(router);
  }
  return routers;
}

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

class AppDynamicCasterType<T> {
  final T Function(String) fromString;
  AppDynamicCasterType(this.fromString);
}

class AppDynamicListCasterType<T> {
  final T Function(List<Map<String, Object?>>) fromMap;
  AppDynamicListCasterType(this.fromMap);
}

Map<String, AppDynamicCasterType> dynamicTypes = {
  "int": AppDynamicCasterType<int>((s) => int.parse(s)),
  "double": AppDynamicCasterType<double>((s) => double.parse(s)),
  "bool": AppDynamicCasterType<bool>((s) => bool.parse(s)),
};

Map<String, AppDynamicListCasterType> dynamicListTypes = {
  "List<Router>": AppDynamicListCasterType<List<Router>>((s) => parseRouters(s)),
  "List<Client>": AppDynamicListCasterType<List<Client>>((s) => parseClients(s)),
  "List<Invoice>": AppDynamicListCasterType<List<Invoice>>((s) => parseInvoices(s)),
};

Future<dynamic> generateVariable(Config config) async {
  return null;
}