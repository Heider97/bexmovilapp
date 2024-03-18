//domain
import '../../domain/models/config.dart';
import '../../domain/models/feature.dart';
import '../../domain/models/kpi.dart';
import '../../domain/models/application.dart';
import '../../domain/models/router.dart';
import '../../domain/models/client.dart';
import '../../domain/models/invoice.dart';
import '../../domain/models/logic_query.dart';

List<Feature> parseFeatures(List<Map<String, dynamic>> featureLists) {
  final features = <Feature>[];
  for (var featureMap in featureLists) {
    final client = Feature.fromMap(featureMap);
    features.add(client);
  }
  return features;
}

List<Application> parseApplications(
    List<Map<String, dynamic>> applicationList) {
  final applications = <Application>[];
  for (var applicationMap in applicationList) {
    final application = Application.fromJson(applicationMap);
    applications.add(application);
  }
  return applications;
}

List<Kpi> parseKpis(List<Map<String, dynamic>> kpiList) {
  final kpis = <Kpi>[];
  for (var kpiMap in kpiList) {
    final kpi = Kpi.fromJson(kpiMap);
    kpis.add(kpi);
  }
  return kpis;
}

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

List<LogicQuery> parseLogicQuery(List<Map<String, dynamic>> logicList) {
  final logics = <LogicQuery>[];
  for (var logicMap in logicList) {
    final logic = LogicQuery.fromJson(logicMap);
    logics.add(logic);
  }
  return logics;
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
  "List<Feature>":
      AppDynamicListCasterType<List<Feature>>((s) => parseFeatures(s)),
  "List<Application>":
      AppDynamicListCasterType<List<Application>>((s) => parseApplications(s)),
  "List<Kpi>": AppDynamicListCasterType<List<Kpi>>((s) => parseKpis(s)),
  "List<Router>":
      AppDynamicListCasterType<List<Router>>((s) => parseRouters(s)),
  "List<Client>":
      AppDynamicListCasterType<List<Client>>((s) => parseClients(s)),
  "List<Invoice>":
      AppDynamicListCasterType<List<Invoice>>((s) => parseInvoices(s)),
  "List<LogicQuery>":
      AppDynamicListCasterType<List<LogicQuery>>((s) => parseLogicQuery(s)),
};

Future<dynamic> generateVariable(Config config) async {
  return null;
}
