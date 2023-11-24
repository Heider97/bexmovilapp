import '../../domain/repositories/database_repository.dart';
import '../datasources/local/app_database.dart';

//models
import '../../domain/models/processing_queue.dart';
import '../../domain/models/clients.dart';

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
  // ignore: override_on_non_overriding_member
  @override
  Future<int> updateSyncFeatures(Clients clients) async {
    return _appDatabase.syncfeaturesDao.updateClients(clients);
  }

  @override
  Future<int> insertSyncFeatures(Clients clients) async {
    return _appDatabase.syncfeaturesDao.insertClients(clients);
  }

  @override
  Future<void> getSyncFeatures(Clients clients) {
    return _appDatabase.syncfeaturesDao.getAllClients();
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