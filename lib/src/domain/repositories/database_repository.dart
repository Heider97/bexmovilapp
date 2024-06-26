import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/product.dart';
import '../models/view.dart';
import '../models/bloc.dart';
import '../models/bloc_event.dart';
import '../models/module.dart';
import '../models/section.dart';
import '../models/widget.dart';
import '../models/component.dart';
import '../models/logic.dart';
import '../models/query.dart';
import '../models/raw_query.dart';
import '../models/navigation.dart';

import '../models/processing_queue.dart';
import '../models/config.dart';
import '../models/router.dart';
import '../models/client.dart';
import '../models/invoice.dart';
import '../models/location.dart';
import '../models/error.dart';
import '../models/filter.dart';
import '../models/option.dart';
import '../models/feature.dart';

abstract class DatabaseRepository {
  //DATABASE
  Future<void> init();
  void close();
  Future<void> emptyAllTables();
  Future<void> emptyAllTablesToSync();
  Future<void> runMigrations(List<String> migrations);
  Future<void> insertAll(String table, List<dynamic> objects);
  Future<List<Map<String, Object?>>> search(String table);

  Future<List<Map<String, Object?>>> query(
      String table, String? where, List<dynamic>? values);
  Future<Map<String, Object?>> querySingle(
      String table, String? where, List<dynamic>? values);
  Future<List<Map<String, Object?>>> rawQuery(String sentence);
  Future<Map<String, Object?>> rawQuerySingle(String sentence);
  Future<List<Map<String, Object?>>> logicQueries(int componentId);
  Future<bool> listenForTableChanges(String? table);

  //VIEWS
  Future<View?> findView(String name);
  Future<void> emptyViews();

  //BLOCS
  Future<Bloc?> findBloc(String name);
  Future<void> emptyBlocs();

  //BLOC EVENTS
  Future<BlocEvent?> findBlocEvent(String name);
  Future<void> emptyBlocEvents();

  //MODULES
  Future<Module?> findModule(String name);
  Future<void> emptyModules();

  //SECTIONS
  Future<List<Section>?> findSections(int moduleId);
  Future<void> emptySections();

  //WIDGETS
  Future<List<Widget>?> findWidgets(int sectionId);
  Future<List<Widget>?> findWidgetsByBloc(int appBlocId);
  Future<void> emptyWidgets();

  //COMPONENTS
  Future<List<Component>?> findComponents(int widgetId);
  Future<void> emptyComponents();

  //LOGICS
  Future<Logic?> findLogic(int id);
  Future<bool> validateLogic(Logic logic, String seller);

  //QUERIES | RAW-QUERIES
  Future<Query?> findQuery(int id);
  Future<void> emptyQueries();

  //RAW QUERIES
  Future<RawQuery?> findRawQuery(int id);
  Future<void> emptyRawQueries();

  //NAVIGATIONS
  Future<Navigation?> findNavigation(int id);
  Future<void> emptyNavigations();

  //FEATURES
  Future<List<Feature>> getAllFeatures();
  Future<void> insertFeatures(List<Feature> features);

  //CLIENT
  Future<List<Client>> getClientsByAgeRange(String range, String seller);
  Future<List<Invoice>> getInvoicesByClient(
      String range, String seller, String client);

  //ROUTERS
  Future<List<Router>> getAllRoutersGroupByClient(String seller);
  //Future<List<Client>> getAllClientsRouter(String seller, String dayRouter);
  Future<List<Router>> getAllRouters(String seller);
  Future<List<LatLng>> getPolyline(String codeRouter);

  //CONFIGS
  Future<List<Config>> getConfigs(String module);
  Future<void> insertConfigs(List<Config> configs);
  Future<int> updateConfig(Config config);
  Future<void> emptyConfigs();

  //LOCATIONS
  Stream<List<Location>> watchAllLocations();
  Future<List<Location>> getAllLocations();
  Future<Location?> getLastLocation();
  Future<bool> countLocationsManager();
  Future<String> getLocationsToSend();
  Future<int?> updateLocationsManager();
  Future<int> updateLocation(Location location);
  Future<void> insertLocation(Location location);
  Future<void> emptyLocations();

  //ERROR
  Future<List<Error>> getAllErrors();
  Future<int> insertError(Error error);
  Future<int> updateError(Error error);
  Future<int> deleteError(Error error);
  Future<void> insertErrors(List<Error> errors);
  Future<void> emptyErrors();

  //FILTERS
  Future<List<Filter>> getAllFilters();
  Future<int> insertFilter(Filter filter);
  Future<int> updateFilter(Filter filter);
  Future<void> insertFilters(List<Filter> filters);
  Future<void> emptyFilters();

  //OPTIONS
  Future<List<Option>> getAllOptionsByFilter(int filterId);
  Future<int> insertOption(Option option);
  Future<int> updateOption(Option option);
  Future<void> insertOptions(List<Option> options);
  Future<void> emptyOptions();

  //PROCESSING QUEUE
  Future<List<ProcessingQueue>> getAllProcessingQueues(
      String? code, String? task);
  Future<List<ProcessingQueue>> getAllProcessingQueuesPaginated(
      int? page, int? limit);
  Future<ProcessingQueue> findProcessingQueue(int id);
  Stream<List<ProcessingQueue>> watchAllProcessingQueues();
  Future<List<ProcessingQueue>> getAllProcessingQueuesIncomplete();
  Future<int> countProcessingQueueIncompleteToTransactions();
  Stream<List<Map<String, dynamic>>>
      getProcessingQueueIncompleteToTransactions();
  Future<bool> validateIfProcessingQueueIsIncomplete();
  Future<int> updateProcessingQueue(ProcessingQueue processingQueue);
  Future<int> insertProcessingQueue(ProcessingQueue processingQueue);
  Future<void> emptyProcessingQueues();

  //SHIPPING CART

  Future<Product> getProductById(
      String productId, String codPrecio, String codBodega);
  Future<List<String>> getProductsByRouterAndClient(
      String codrouter, String codcliente);
  Future<int> getStockByProduct(String productId, String cartId);
  Future<void> insertCart(
      String codrouter,
      String codPrecio,
      String codBodega,
      String codcliente,
      String codproducts,
      int quantity,
      String state,
      String date);

  Future<int> getTotalProductQuantity(
      String codrouter, String codPrecio, String codBodega, String codcliente);

  Future<int> getTotalProductQuantityAlreadyExist(String codrouter,
      String codPrecio, String codBodega, String codcliente, String productId);

  Future<double> getTotalProductValue(
      String codrouter, String codPrecio, String codBodega, String codcliente);

  Future<CartProductInfo> getCartProductInfo(
      String codrouter, String codcliente, String codPrecio, String codBodega);

  Future<void> deleteProductAndUpdateCart(
      String codrouter,
      String codPrecio,
      String codBodega,
      String codcliente,
      String productId);
}
