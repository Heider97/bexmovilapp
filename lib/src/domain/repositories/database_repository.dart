import '../models/processing_queue.dart';
import '../models/category.dart';

abstract class DatabaseRepository {
  //DATABASE
  Future<void> init();
  void close();

  //PROCESSING QUEUE
  Future<int> updateProcessingQueue(ProcessingQueue processingQueue);
  Future<void> insertProcessingQueue(ProcessingQueue processingQueue);
  Future<void> emptyProcessingQueues();
}
