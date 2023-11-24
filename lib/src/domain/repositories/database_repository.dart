import '../models/clients.dart';
import '../models/processing_queue.dart';
import '../models/client.dart';


abstract class DatabaseRepository {
  //DATABASE
  Future<void> init();
  void close();

  //SYNC FEATURES
  Future<List<Feature>> getFeatures();
  Future<void> insertFeatures(List<Feature> features);
  Future<int> updateFeatures(Feature client);
  Future<void> emptyFeatures();

  //PROCESSING QUEUE
  Future<int> updateProcessingQueue(ProcessingQueue processingQueue);
  Future<void> insertProcessingQueue(ProcessingQueue processingQueue);
  Future<void> emptyProcessingQueues();
}
