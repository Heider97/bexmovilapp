import '../models/feature.dart';
import '../models/processing_queue.dart';
import '../models/config.dart';


abstract class DatabaseRepository {
  //DATABASE
  Future<void> init(String? version, List<String> migrations);
  void close();

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

  //PROCESSING QUEUE
  Future<int> updateProcessingQueue(ProcessingQueue processingQueue);
  Future<void> insertProcessingQueue(ProcessingQueue processingQueue);
  Future<void> emptyProcessingQueues();
}
