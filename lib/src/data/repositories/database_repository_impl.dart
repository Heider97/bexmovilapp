import '../datasources/local/app_database.dart';
import '../../domain/repositories/database_repository.dart';
//models
import '../../domain/models/module.dart';
import '../../domain/models/component.dart';
import '../../domain/models/query.dart';

import '../../domain/models/processing_queue.dart';
import '../../domain/models/feature.dart';
import '../../domain/models/config.dart';
import '../../domain/models/kpi.dart';
import '../../domain/models/router.dart';
import '../../domain/models/application.dart';
import '../../domain/models/client.dart';
import '../../domain/models/graphic.dart';
import '../../domain/models/location.dart';
import '../../domain/models/error.dart';
import '../../domain/models/filter.dart';
import '../../domain/models/option.dart';
import '../../domain/models/invoice.dart';

class DatabaseRepositoryImpl implements DatabaseRepository {
  final AppDatabase _appDatabase;

  DatabaseRepositoryImpl(this._appDatabase);

  //MODULES
  @override
  Future<void> insertModules(List<Module> modules) async {
    return _appDatabase.moduleDao.insertModules(modules);
  }

  @override
  Future<Module?> findModule(String name) async {
    return _appDatabase.moduleDao.findModule(name);
  }

  @override
  Future<void> emptyModules() async {
    return _appDatabase.moduleDao.emptyModules();
  }

  //COMPONENTS
  @override
  Future<void> insertComponents(List<Component> components) async {
    return _appDatabase.componentDao.insertComponents(components);
  }

  @override
  Future<Component?> findComponent(String name, int moduleId) async {
    return _appDatabase.componentDao.findComponent(name, moduleId);
  }

  @override
  Future<void> emptyComponents() async {
    return _appDatabase.componentDao.emptyComponents();
  }

  //QUERIES
  @override
  Future<void> insertQueries(List<Query> queries) async {
    return _appDatabase.queryDao.insertQueries(queries);
  }

  @override
  Future<Query?> findQuery(int componentId, bool isSingle) async {
    return _appDatabase.queryDao.findQuery(componentId, isSingle);
  }

  @override
  Future<void> emptyQueries() async {
    return _appDatabase.queryDao.emptyQueries();
  }

  //ROUTER
  @override
  Future<List<Router>> getAllRoutersGroupByClient(String seller) async {
    return _appDatabase.routerDao.getAllRoutersGroupByClient(seller);
  }

  //CLIENTS
  @override
  Future<List<Client>> getClientsByAgeRange(String range, String seller) {
    return _appDatabase.clientDao.getClientInformationByAgeRange(range, seller);
  }

  @override
  Future<List<Invoice>> getInvoicesByClient(
      String range, String seller, String client) {
    return _appDatabase.clientDao.getInvoicesByClient(range, seller, client);
  }

  @override
  Future<List<Client>> getAllClientsRouter(
      String seller, String dayRouter) async {
    return _appDatabase.clientDao.getAllClientsRouter(seller, dayRouter);
  }

  @override
  Future<List<Router>> getAllRouters(String seller) async {
    return _appDatabase.routerDao.getAllRouters(seller);
  }

  //PROCESSING QUEUE
  @override
  Future<List<ProcessingQueue>> getAllProcessingQueues() async {
    return _appDatabase.processingQueueDao.getAllProcessingQueues();
  }

  @override
  Future<int> updateProcessingQueue(ProcessingQueue processingQueue) async {
    return _appDatabase.processingQueueDao
        .updateProcessingQueue(processingQueue);
  }

  @override
  Future<int> insertProcessingQueue(ProcessingQueue processingQueue) async {
    return _appDatabase.processingQueueDao
        .insertProcessingQueue(processingQueue);
  }

  @override
  Future<void> emptyProcessingQueues() async {
    return _appDatabase.processingQueueDao.emptyProcessingQueue();
  }

  //CONFIGS
  @override
  Future<List<Config>> getConfigs(String module) {
    return _appDatabase.configDao.getAllConfigs(module);
  }

  @override
  Future<void> insertConfigs(List<Config> configs) async {
    return _appDatabase.configDao.insertConfigs(configs);
  }

  @override
  Future<int> updateConfig(Config configs) async {
    return _appDatabase.configDao.updateConfig(configs);
  }

  @override
  Future<void> emptyConfigs() {
    return _appDatabase.configDao.emptyConfigs();
  }

  //FEATURES
  @override
  Future<List<Feature>> getAllFeatures() {
    return _appDatabase.featureDao.getAllFeatures();
  }

  @override
  Future<void> insertFeatures(List<Feature> features) async {
    return _appDatabase.featureDao.insertFeatures(features);
  }

  @override
  Future<int> updateFeature(Feature clients) async {
    return _appDatabase.featureDao.updateFeature(clients);
  }

  @override
  Future<void> emptyFeatures() {
    return _appDatabase.featureDao.emptyFeature();
  }

  //KPIS
  @override
  Future<List<Kpi>> getKpisByLine(String line) {
    return _appDatabase.kpiDao.getKpisByLine(line);
  }

  @override
  Future<void> insertKpis(List<Kpi> kpis) async {
    return _appDatabase.kpiDao.insertKpis(kpis);
  }

  @override
  Future<int> insertKpi(Kpi kpi) async {
    return _appDatabase.kpiDao.insertKpi(kpi);
  }

  @override
  Future<int> updateKpi(Kpi kpi) async {
    return _appDatabase.kpiDao.updateKpi(kpi);
  }

  @override
  Future<void> emptyKpis() {
    return _appDatabase.kpiDao.emptyKpis();
  }

  //APPLICATIONS
  @override
  Future<List<Application>> getAllApplications() {
    return _appDatabase.applicationDao.getAllApplications();
  }

  @override
  Future<void> insertApplication(Application application) {
    return _appDatabase.applicationDao.insertApplication(application);
  }

  @override
  Future<void> insertApplications(List<Application> applications) {
    return _appDatabase.applicationDao.insertApplications(applications);
  }

  @override
  Future<int> updateApplication(Application application) {
    return _appDatabase.applicationDao.updateApplication(application);
  }

  @override
  Future<void> emptyApplications() {
    return _appDatabase.applicationDao.emptyApplications();
  }

  //GRAPHICS
  @override
  Future<List<Graphic>> getAllGraphics() {
    return _appDatabase.graphicDao.getAllGraphics();
  }

  @override
  Future<void> insertGraphic(Graphic graphic) {
    return _appDatabase.graphicDao.insertGraphic(graphic);
  }

  @override
  Future<void> insertGraphics(List<Graphic> graphics) {
    return _appDatabase.graphicDao.insertGraphics(graphics);
  }

  @override
  Future<int> updateGraphic(Graphic graphic) {
    return _appDatabase.graphicDao.updateGraphic(graphic);
  }

  @override
  Future<void> emptyGraphics() {
    return _appDatabase.graphicDao.emptyGraphics();
  }

  //LOCATIONS
  @override
  Stream<List<Location>> watchAllLocations() {
    return _appDatabase.locationDao.watchAllLocations();
  }

  @override
  Future<List<Location>> getAllLocations() async {
    return _appDatabase.locationDao.getAllLocations();
  }

  @override
  Future<Location?> getLastLocation() async {
    return _appDatabase.locationDao.getLastLocation();
  }

  @override
  Future<bool> countLocationsManager() async {
    return _appDatabase.locationDao.countLocationsManager();
  }

  @override
  Future<String> getLocationsToSend() async {
    return _appDatabase.locationDao.getLocationsToSend();
  }

  @override
  Future<int?> updateLocationsManager() async {
    return _appDatabase.locationDao.updateLocationsManager();
  }

  @override
  Future<int> updateLocation(Location location) async {
    return _appDatabase.locationDao.updateLocation(location);
  }

  @override
  Future<int> insertLocation(Location location) async {
    return _appDatabase.locationDao.insertLocation(location);
  }

  @override
  Future<void> emptyLocations() async {
    return _appDatabase.locationDao.emptyLocations();
  }

  //ERROR
  @override
  Future<List<Error>> getAllErrors() async {
    return _appDatabase.errorDao.getAllErrors();
  }

  @override
  Future<int> insertError(Error error) async {
    return _appDatabase.errorDao.insertError(error);
  }

  @override
  Future<int> updateError(Error error) async {
    return _appDatabase.errorDao.updateError(error);
  }

  @override
  Future<int> deleteError(Error error) async {
    return _appDatabase.errorDao.deleteError(error);
  }

  @override
  Future<void> insertErrors(List<Error> errors) async {
    return _appDatabase.errorDao.insertErrors(errors);
  }

  @override
  Future<void> emptyErrors() async {
    return _appDatabase.errorDao.emptyErrors();
  }

  //FILTERS
  @override
  Future<List<Filter>> getAllFilters() async {
    return _appDatabase.filterDao.getAllFilters();
  }

  @override
  Future<int> insertFilter(Filter filter) async {
    return _appDatabase.filterDao.insertFilter(filter);
  }

  @override
  Future<int> updateFilter(Filter filter) async {
    return _appDatabase.filterDao.updateFilter(filter);
  }

  @override
  Future<void> insertFilters(List<Filter> filters) async {
    return _appDatabase.filterDao.insertFilters(filters);
  }

  @override
  Future<void> emptyFilters() async {
    return _appDatabase.filterDao.emptyFilters();
  }

  //OPTIONS
  @override
  Future<List<Option>> getAllOptionsByFilter(int filterId) async {
    return _appDatabase.optionDao.getAllOptionsByFilter(filterId);
  }

  @override
  Future<int> insertOption(Option option) async {
    return _appDatabase.optionDao.insertOption(option);
  }

  @override
  Future<int> updateOption(Option option) async {
    return _appDatabase.optionDao.updateOption(option);
  }

  @override
  Future<void> insertOptions(List<Option> options) async {
    return _appDatabase.optionDao.insertOptions(options);
  }

  @override
  Future<void> emptyOptions() async {
    return _appDatabase.optionDao.emptyOptions();
  }

  // initialize and close methods go here
  @override
  Future<void> init() async {
    await _appDatabase.database;
    return Future.value();
  }

  @override
  Future<List<Map<String, Object?>>> query(
      String table, String type, String? where, List<dynamic>? values) async {
    return await _appDatabase.query(table, type, where, values);
  }

  @override
  Future<List<Map<String, Object?>>> search(String table) async {
    return await _appDatabase.search(table);
  }

  @override
  Future<void> insertAll(String table, List<dynamic> objects) {
    return _appDatabase.insertAll(table, objects);
  }

  @override
  Future<void> runMigrations(List<String> migrations) {
    return _appDatabase.runMigrations(migrations);
  }

  @override
  void close() {
    _appDatabase.close();
  }

  @override
  Future<bool> listenForTableChanges(String? table) {
    return _appDatabase.listenForTableChanges(table);
  }
}
