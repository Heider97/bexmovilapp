import '../models/clients.dart';
import '../models/processing_queue.dart';

abstract class DatabaseRepository {
  //DATABASE
  Future<void> init();
  void close();

  //SYNC FEATURES
  Future<void> getSyncFeatures(Clients clients);

  //PROCESSING QUEUE
  Future<int> updateProcessingQueue(ProcessingQueue processingQueue);
  Future<void> insertProcessingQueue(ProcessingQueue processingQueue);
  Future<void> emptyProcessingQueues();
}
