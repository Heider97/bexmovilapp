//domain
import 'package:bexmovil/src/domain/models/arguments.dart';
import 'package:bexmovil/src/domain/models/product.dart';
import 'package:bexmovil/src/domain/models/warehouse.dart';

import '../../domain/models/config.dart';
import '../../domain/models/feature.dart';
import '../../domain/models/graphic.dart';
import '../../domain/models/kpi.dart';
import '../../domain/models/application.dart';
import '../../domain/models/price.dart';
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

List<Warehouse> parseWarehouses(List<Map<String, dynamic>> warehouseList) {
  final warehouses = <Warehouse>[];
  for (var warehouseMap in warehouseList) {
    final warehouse = Warehouse.fromJson(warehouseMap);
    warehouses.add(warehouse);
  }
  return warehouses;
}

List<Price> parsePrices(List<Map<String, dynamic>> priceList) {
  final prices = <Price>[];
  for (var priceMap in priceList) {
    final price = Price.fromJson(priceMap);
    prices.add(price);
  }
  return prices;
}

List<Product> parseProducts(List<Map<String, dynamic>> productList) {
  final products = <Product>[];
  for (var productMap in productList) {
    final price = Product.fromJson(productMap);
    products.add(price);
  }
  return products;
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

List<ChartData> parseChartData(List<Map<String, dynamic>> chartDataList) {
  final data = <ChartData>[];
  for (var logicMap in chartDataList) {
    final logic = ChartData.fromJson(logicMap);
    data.add(logic);
  }
  return data;
}

class AppDynamicCasterType<T> {
  final T Function(String) fromString;
  AppDynamicCasterType(this.fromString);
}

class AppDynamicDataCasterType<T> {
  final T Function(Map<String, Object?>) fromMap;

  AppDynamicDataCasterType(this.fromMap);
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
  "List<Warehouse>":
      AppDynamicListCasterType<List<Warehouse>>((s) => parseWarehouses(s)),
  "List<Price>": AppDynamicListCasterType<List<Price>>((s) => parsePrices(s)),
  "List<Product>":
      AppDynamicListCasterType<List<Product>>((s) => parseProducts(s)),
  "List<Invoice>":
      AppDynamicListCasterType<List<Invoice>>((s) => parseInvoices(s)),
  "List<LogicQuery>":
      AppDynamicListCasterType<List<LogicQuery>>((s) => parseLogicQuery(s)),
  "List<ChartData>":
      AppDynamicListCasterType<List<ChartData>>((s) => parseChartData(s)),
};

Map<String, AppDynamicDataCasterType> dynamicDataTypes = {
  "Kpi": AppDynamicDataCasterType<Kpi>((s) => Kpi.fromJson(s)),
  "ProductsArguments": AppDynamicDataCasterType<ProductArgument>(
      (s) => ProductArgument.fromJson(s)),
};

Future<dynamic> generateVariable(Config config) async {
  return null;
}
