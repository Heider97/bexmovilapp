import 'package:bexmovil/src/domain/models/client.dart';

import '../models/feature.dart';
import '../models/processing_queue.dart';
import '../models/config.dart';

abstract class DatabaseRepository {
  //DATABASE
  Future<void> init(int? version, List<String> migrations);
  void close();
  Future<void> runMigrations(List<String> migrations);
  Future<void> insertAll(String table, List<dynamic> objects);

  //CONFIGS
  Future<List<Config>> getConfigs();
  Future<void> insertConfigs(List<Config> features);
  Future<int> updateConfig(Config config);
  Future<void> emptyConfigs();

  //FEATURES
  Future<List<Feature>> getFeatures();
  Future<void> insertFeatures(List<Feature> features);
  Future<int> updateFeature(Feature feature);
  Future<void> emptyFeatures();

  //CLIENTS
  Future<List<Client>> getClients();
  Future<void> insertClient(Client features);
  Future<int> updateClient(Client feature);
  Future<void> emptyClient();

  //PROCESSING QUEUE
  Future<List<ProcessingQueue>> getAllProcessingQueues();
  Future<int> updateProcessingQueue(ProcessingQueue processingQueue);
  Future<void> insertProcessingQueue(ProcessingQueue processingQueue);
  Future<void> emptyProcessingQueues();
}
