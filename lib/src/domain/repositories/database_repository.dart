import '../models/processing_queue.dart';

abstract class DatabaseRepository {
  //DATABASE
  Future<void> init();

  //PROCESSING QUEUE
  Future<int> updateProcessingQueue(ProcessingQueue processingQueue);
  Future<void> insertProcessingQueue(ProcessingQueue processingQueue);
  Future<void> emptyProcessingQueues();
}
