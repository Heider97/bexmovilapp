import '../../domain/repositories/database_repository.dart';
import '../datasources/local/app_database.dart';

//models
import '../../domain/models/processing_queue.dart';

class DatabaseRepositoryImpl implements DatabaseRepository {
  final DatabaseHelper _appDatabase;

  DatabaseRepositoryImpl(this._appDatabase);

  @override
  Future<void> emptyProcessingQueues() {
    // TODO: implement emptyProcessingQueues
    throw UnimplementedError();
  }

  @override
  Future<void> init() {
    // TODO: implement init
    throw UnimplementedError();
  }

  @override
  Future<void> insertProcessingQueue(ProcessingQueue processingQueue) {
    // TODO: implement insertProcessingQueue
    throw UnimplementedError();
  }

  @override
  Future<int> updateProcessingQueue(ProcessingQueue processingQueue) {
    // TODO: implement updateProcessingQueue
    throw UnimplementedError();
  }
}
