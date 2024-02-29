import 'package:bexmovil/src/domain/models/responses/kpi_response.dart';

import '../models/feature.dart';
import '../models/processing_queue.dart';
import '../models/config.dart';
import '../models/router.dart';
import '../models/application.dart';

abstract class DatabaseRepository {
  //DATABASE
  Future<void> init();
  void close();
  Future<void> runMigrations(List<String> migrations);
  Future<void> insertAll(String table, List<dynamic> objects);
  Future<List<Map<String, Object?>>> search(String table);

  //ROUTERS
  Future<List<Router>> getAllRoutersGroupByClient(String seller);
  Future<List<Router>> getAllClientsRouter(String seller, String dayRouter);
  Future<List<Router>> getAllRouters(String seller);

  //CONFIGS
  Future<List<Config>> getConfigs();
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

  //PROCESSING QUEUE
  Future<List<ProcessingQueue>> getAllProcessingQueues();
  Future<int> updateProcessingQueue(ProcessingQueue processingQueue);
  Future<void> insertProcessingQueue(ProcessingQueue processingQueue);
  Future<void> emptyProcessingQueues();
}
