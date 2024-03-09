import '../models/feature.dart';
import '../models/graphic.dart';
import '../models/processing_queue.dart';
import '../models/config.dart';
import '../models/router.dart';
import '../models/application.dart';
import '../models/client.dart';
import '../models/invoice.dart';
import '../models/kpi.dart';
import '../models/location.dart';
import '../models/error.dart';
import '../models/filter.dart';
import '../models/option.dart';

abstract class DatabaseRepository {
  //DATABASE
  Future<void> init();
  void close();
  Future<void> runMigrations(List<String> migrations);
  Future<void> insertAll(String table, List<dynamic> objects);
  Future<List<Map<String, Object?>>> search(String table);
  Future<List<Map<String, Object?>>> query(
      String table, String type, String? where, List<dynamic>? values);
  Future<bool> listenForTableChanges(String? table);

  //CLIENT
  Future<List<Client>> getClientsByAgeRange(String range, String seller);
  Future<List<Invoice>> getInvoicesByClient(
      String range, String seller, String client);

  //ROUTERS
  Future<List<Router>> getAllRoutersGroupByClient(String seller);
  Future<List<Client>> getAllClientsRouter(String seller, String dayRouter);
  Future<List<Router>> getAllRouters(String seller);

  //CONFIGS
  Future<List<Config>> getConfigs(String module);
  Future<void> insertConfigs(List<Config> configs);
  Future<int> updateConfig(Config config);
  Future<void> emptyConfigs();

  //FEATURES
  Future<List<Feature>> getAllFeatures();
  Future<void> insertFeatures(List<Feature> features);
  Future<int> updateFeature(Feature feature);
  Future<void> emptyFeatures();

  //KPIS
  Future<List<Kpi>> getKpisByLine(String line);
  Future<void> insertKpis(List<Kpi> kpis);
  Future<void> insertKpi(Kpi kpi);
  Future<int> updateKpi(Kpi kpi);
  Future<void> emptyKpis();

  //APPLICATIONS
  Future<List<Application>> getAllApplications();
  Future<void> insertApplications(List<Application> applications);
  Future<void> insertApplication(Application application);
  Future<int> updateApplication(Application application);
  Future<void> emptyApplications();

  //GRAPHICS
  Future<List<Graphic>> getAllGraphics();
  Future<void> insertGraphics(List<Graphic> graphics);
  Future<void> insertGraphic(Graphic graphic);
  Future<int> updateGraphic(Graphic graphic);
  Future<void> emptyGraphics();

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
  Future<List<ProcessingQueue>> getAllProcessingQueues();
  Future<int> updateProcessingQueue(ProcessingQueue processingQueue);
  Future<void> insertProcessingQueue(ProcessingQueue processingQueue);
  Future<void> emptyProcessingQueues();
}
