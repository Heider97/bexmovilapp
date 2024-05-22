import 'package:bexmovil/src/domain/models/product.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../datasources/local/app_database.dart';
import '../../domain/repositories/database_repository.dart';

//models
import '../../domain/models/view.dart';
import '../../domain/models/bloc.dart';
import '../../domain/models/bloc_event.dart';
import '../../domain/models/module.dart';
import '../../domain/models/section.dart';
import '../../domain/models/widget.dart';
import '../../domain/models/component.dart';
import '../../domain/models/logic.dart';
import '../../domain/models/query.dart';
import '../../domain/models/raw_query.dart';
import '../../domain/models/navigation.dart';

import '../../domain/models/processing_queue.dart';
import '../../domain/models/feature.dart';
import '../../domain/models/config.dart';
import '../../domain/models/router.dart';
import '../../domain/models/client.dart';
import '../../domain/models/location.dart';
import '../../domain/models/error.dart';
import '../../domain/models/filter.dart';
import '../../domain/models/option.dart';
import '../../domain/models/invoice.dart';

class DatabaseRepositoryImpl implements DatabaseRepository {
  final AppDatabase _appDatabase;

  DatabaseRepositoryImpl(this._appDatabase);

  //BLOCS
  @override
  Future<Bloc?> findBloc(String name) async {
    return _appDatabase.blocDao.findBloc(name);
  }

  @override
  Future<void> emptyBlocs() async {
    return _appDatabase.blocDao.emptyBlocs();
  }

  //BLOC EVENTS
  @override
  Future<BlocEvent?> findBlocEvent(String name) async {
    return _appDatabase.blocEventDao.findBlocEvent(name);
  }

  @override
  Future<void> emptyBlocEvents() async {
    return _appDatabase.blocEventDao.emptyBlocEvents();
  }

  //VIEWS
  @override
  Future<View?> findView(String name) async {
    return _appDatabase.viewDao.findView(name);
  }

  @override
  Future<void> emptyViews() async {
    return _appDatabase.viewDao.emptyViews();
  }

  //MODULES
  @override
  Future<Module?> findModule(String name) async {
    return _appDatabase.moduleDao.findModule(name);
  }

  @override
  Future<void> emptyModules() async {
    return _appDatabase.moduleDao.emptyModules();
  }

  //SECTIONS
  @override
  Future<List<Section>?> findSections(int moduleId) async {
    return _appDatabase.sectionDao.findSections(moduleId);
  }

  @override
  Future<void> emptySections() async {
    return _appDatabase.sectionDao.emptySections();
  }

  //WIDGETS
  @override
  Future<List<Widget>?> findWidgets(int sectionId) async {
    return _appDatabase.widgetDao.findWidgets(sectionId);
  }

  @override
  Future<List<Widget>?> findWidgetsByBloc(int appBlocId) async {
    return _appDatabase.widgetDao.findWidgetsByBloc(appBlocId);
  }

  @override
  Future<void> emptyWidgets() async {
    return _appDatabase.widgetDao.emptyWidgets();
  }

  //COMPONENTS
  @override
  Future<List<Component>?> findComponents(int widgetId) async {
    return _appDatabase.componentDao.findComponents(widgetId);
  }

  @override
  Future<void> emptyComponents() async {
    return _appDatabase.componentDao.emptyComponents();
  }

  //LOGICS
  @override
  Future<Logic?> findLogic(int id) async {
    return _appDatabase.logicDao.findLogic(id);
  }

  @override
  Future<bool> validateLogic(Logic logic, String seller) async {
    return _appDatabase.logicDao.validateLogic(logic, seller);
  }

  //QUERIES
  @override
  Future<Query?> findQuery(int id) async {
    return _appDatabase.queryDao.findQuery(id);
  }

  @override
  Future<void> emptyQueries() async {
    return _appDatabase.queryDao.emptyQueries();
  }

  //RAW QUERIES
  @override
  Future<RawQuery?> findRawQuery(int id) async {
    return _appDatabase.rawQueryDao.findRawQuery(id);
  }

  @override
  Future<void> emptyRawQueries() async {
    return _appDatabase.rawQueryDao.emptyRawQueries();
  }

  //RAW QUERIES
  @override
  Future<Navigation?> findNavigation(int id) async {
    return _appDatabase.navigationDao.findNavigation(id);
  }

  @override
  Future<void> emptyNavigations() async {
    return _appDatabase.navigationDao.emptyNavigations();
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

/*   @override
  Future<List<Client>> getAllClientsRouter(
      String seller, String dayRouter) async {
  /*   return _appDatabase.clientDao.getAllClientsRouter(seller, dayRouter) */;
  }
 */
  @override
  Future<List<Router>> getAllRouters(String seller) async {
    return _appDatabase.routerDao.getAllRouters(seller);
  }

  //PROCESSING QUEUE
  @override
  Future<List<ProcessingQueue>> getAllProcessingQueues(String? code, String? task) {
    return _appDatabase.processingQueueDao.getAllProcessingQueues(code, task);
  }

  @override
  Future<ProcessingQueue> findProcessingQueue(int id) {
    return _appDatabase.processingQueueDao.findProcessingQueue(id);
  }

  @override
  Future<List<ProcessingQueue>> getAllProcessingQueuesPaginated(int? page, int? limit) {
    return _appDatabase.processingQueueDao.getAllProcessingQueuesPaginated(page, limit);
  }

  @override
  Stream<List<ProcessingQueue>> watchAllProcessingQueues() {
    return _appDatabase.processingQueueDao.watchAllProcessingQueues();
  }

  @override
  Future<List<ProcessingQueue>> getAllProcessingQueuesIncomplete() async {
    return _appDatabase.processingQueueDao.getAllProcessingQueuesIncomplete();
  }

  @override
  Future<int> countProcessingQueueIncompleteToTransactions() {
    return _appDatabase.processingQueueDao
        .countProcessingQueueIncompleteToTransactions();
  }

  @override
  Stream<List<Map<String, dynamic>>> getProcessingQueueIncompleteToTransactions() {
    return _appDatabase.processingQueueDao
        .getProcessingQueueIncompleteToTransactions();
  }

  @override
  Future<bool> validateIfProcessingQueueIsIncomplete() {
    return _appDatabase.processingQueueDao
        .validateIfProcessingQueueIsIncomplete();
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
  Future<void> emptyFeatures() {
    return _appDatabase.featureDao.emptyFeature();
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
      String table, String? where, List<dynamic>? arguments) async {
    return await _appDatabase.query(table, where, arguments);
  }

  @override
  Future<Map<String, Object?>> querySingle(
      String table, String? where, List<dynamic>? arguments) async {
    return await _appDatabase.querySingle(table, where, arguments);
  }

  @override
  Future<List<Map<String, Object?>>> logicQueries(int componentId) async {
    return await _appDatabase.logicQueries(componentId);
  }

  @override
  Future<List<Map<String, Object?>>> rawQuery(String sentence) async {
    return await _appDatabase.rawQuery(sentence);
  }

  @override
  Future<Map<String, Object?>> rawQuerySingle(String sentence) async {
    return await _appDatabase.rawQuerySingle(sentence);
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
  Future<bool> listenForTableChanges(String? table) {
    return _appDatabase.listenForTableChanges(table);
  }

  @override
  Future<void> emptyAllTables() {
    return _appDatabase.emptyAllTables();
  }

  @override
  Future<void> emptyAllTablesToSync() {
    return _appDatabase.emptyAllTablesToSync();
  }

  @override
  Future<List<LatLng>> getPolyline(String codeRouter) {
    return _appDatabase.routerDao.getRouterPolylines(codeRouter);
  }

  //SHIPPING CART

  @override
  Future<Product> getProductById(
      String productId, String codPrecio, String codBodega) async {
    return await _appDatabase.shoppingCartDao
        .getProductById(productId, codPrecio, codBodega);
  }

  @override
  Future<List<String>> getProductsByRouterAndClient(
      String codrouter, String codcliente) {
    return _appDatabase.shoppingCartDao
        .getProductsByRouterAndClient(codrouter, codcliente);
  }

  @override
  Future<int> getStockByProduct(String productId) {
    return _appDatabase.shoppingCartDao.getStockByProduct(productId);
  }

  @override
  Future<void> insertCart(
      String codrouter,
      String codPrecio,
      String codBodega,
      String codcliente,
      String codproducts,
      int quantity,
      String state,
      String date) {
    return _appDatabase.shoppingCartDao.insertCart(codrouter, codPrecio,
        codBodega, codcliente, codproducts, quantity, state, date);
  }

  @override
  Future<int> getTotalProductQuantity(
      String codrouter, String codPrecio, String codBodega, String codcliente) {
    return _appDatabase.shoppingCartDao
        .getTotalProductQuantity(codrouter, codPrecio, codBodega, codcliente);
  }

  @override
  void close() {
    _appDatabase.close();
  }
}
