import '../../domain/models/client.dart';
import '../../domain/repositories/database_repository.dart';
import '../datasources/local/app_database.dart';

//models
import '../../domain/models/processing_queue.dart';
import '../../domain/models/feature.dart';

class DatabaseRepositoryImpl implements DatabaseRepository {
  final AppDatabase _appDatabase;

  DatabaseRepositoryImpl(this._appDatabase);

  //PROCESSING QUEUE
  @override
  Future<int> updateProcessingQueue(ProcessingQueue processingQueue) async {
    return _appDatabase.processingQueueDao.updateProcessingQueue(processingQueue);
  }

  @override
  Future<int> insertProcessingQueue(ProcessingQueue processingQueue) async {
    return _appDatabase.processingQueueDao.insertProcessingQueue(processingQueue);
  }

  @override
  Future<void> emptyProcessingQueues() async {
    return _appDatabase.processingQueueDao.emptyProcessingQueue();
  }

  //SYNC FEATURES
  @override
  Future<List<Feature>> getFeatures() {
    return _appDatabase.featureDao.getAllFeature();
  }

  @override
  Future<void> insertFeatures(List<Feature> features) async {
    return _appDatabase.featureDao.insertFeatures(features);
  }

  @override
  Future<int> updateFeatures(Feature clients) async {
    return _appDatabase.featureDao.updateFeature(clients);
  }

  @override
  Future<void> emptyFeatures() {
    return _appDatabase.featureDao.emptyFeature();
  }

  // initialize and close methods go here
  @override
  Future<void> init() async {
    await _appDatabase.database;
    return Future.value();
  }

  @override
  void close() {
    _appDatabase.close();
  }
}