import 'package:bexmovil/src/domain/models/client.dart';

import '../datasources/local/app_database.dart';
import '../../domain/repositories/database_repository.dart';
//models
import '../../domain/models/processing_queue.dart';
import '../../domain/models/feature.dart';
import '../../domain/models/config.dart';

class DatabaseRepositoryImpl implements DatabaseRepository {
  final AppDatabase _appDatabase;

  DatabaseRepositoryImpl(this._appDatabase);

  //PROCESSING QUEUE
  @override
  Future<List<ProcessingQueue>> getAllProcessingQueues() async {
    return _appDatabase.processingQueueDao.getAllProcessingQueues();
  }


  @override
  Future<int> updateProcessingQueue(ProcessingQueue processingQueue) async {
    return _appDatabase.processingQueueDao
        .updateProcessingQueue(processingQueue);
  }

  @override
  Future<int> insertProcessingQueue(ProcessingQueue processingQueue) async {
    return _appDatabase.processingQueueDao
        .insertProcessingQueue(processingQueue);
  }

  @override
  Future<void> emptyProcessingQueues() async {
    return _appDatabase.processingQueueDao.emptyProcessingQueue();
  }

  //CONFIGS
  @override
  Future<List<Config>> getConfigs() {
    return _appDatabase.configDao.getAllConfigs();
  }

  @override
  Future<void> insertConfigs(List<Config> configs) async {
    return _appDatabase.configDao.insertConfigs(configs);
  }

  @override
  Future<int> updateConfig(Config configs) async {
    return _appDatabase.configDao.updateConfig(configs);
  }

  @override
  Future<void> emptyConfigs() {
    return _appDatabase.configDao.emptyConfigs();
  }

  //FEATURES

  @override
  Future<List<Feature>> getFeatures() {
    return _appDatabase.featureDao.getAllFeature();
  }

  @override
  Future<void> insertFeatures(List<Feature> features) async {
    return _appDatabase.featureDao.insertFeatures(features);
  }

  @override
  Future<int> updateFeature(Feature clients) async {
    return _appDatabase.featureDao.updateFeature(clients);
  }

  @override
  Future<void> emptyFeatures() {
    return _appDatabase.featureDao.emptyFeature();
  }

  // initialize and close methods go here
  @override
  Future<void> init(int? version, List<String> migrations) async {
    await _appDatabase.database(version, migrations);
    return Future.value();
  }

  @override
  Future<void> insertAll(String table, List<dynamic> objects) {
    return _appDatabase.insertAll(table, objects);
  }

  @override
  Future<void> runMigrations(List<String> migrations) {
    return _appDatabase.runMigrations(migrations);
  }

  //CLIENTS
  @override
  Future<List<Client>> getClients() async {
    return await _appDatabase.clientDao.getAllClients();
  }

  @override
  Future<int> updateClient(Client client) async {
    return _appDatabase.clientDao.updateClient(client);
  }

  @override
  Future<int> insertClient(Client client) async {
    return _appDatabase.clientDao.insertClient(client);
  }

  @override
  Future<void> emptyClient() async {
    _appDatabase.clientDao.emptyClients();
  }

  @override
  void close() {
    _appDatabase.close();
  }
}
