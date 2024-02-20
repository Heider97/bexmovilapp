import 'package:bexmovil/src/domain/models/client.dart';
import 'package:bexmovil/src/domain/models/responses/kpi_response.dart';

import '../datasources/local/app_database.dart';
import '../../domain/repositories/database_repository.dart';
//models
import '../../domain/models/processing_queue.dart';
import '../../domain/models/feature.dart';
import '../../domain/models/config.dart';
import '../../domain/models/kpi.dart';

class DatabaseRepositoryImpl implements DatabaseRepository {
  final AppDatabase _appDatabase;

  DatabaseRepositoryImpl(this._appDatabase);

  //GLOBAL
  @override
  Future<List<Map<String, Object?>>> findGlobal(String table, String condition, String value) async {
    return _appDatabase.findGlobal(table, condition, value);
  }


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
  Future<List<Feature>> getAllFeatures() {
    return _appDatabase.featureDao.getAllFeatures();
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

  //KPIS
  @override
  Future<List<Kpi>> getAllKpis() {
    return _appDatabase.kpiDao.getAllKpis();
  }

  @override
  Future<void> insertKpis(List<Kpi> kpis) async {
    return _appDatabase.kpiDao.insertKpis(kpis);
  }

  @override
  Future<int> insertKpi(Kpi kpi) async {
    return _appDatabase.kpiDao.insertKpi(kpi);
  }

  @override
  Future<int> updateKpi(Kpi kpi) async {
    return _appDatabase.kpiDao.updateKpi(kpi);
  }

  @override
  Future<void> emptyKpis() {
    return _appDatabase.kpiDao.emptyKpis();
  }

  // initialize and close methods go here
  @override
  Future<void> init() async {
    await _appDatabase.database;
    return Future.value();
  }

  @override
  Future<List<Map<String, Object?>>> search(String table) async {
    return await _appDatabase.search(table);
  }

  @override
  Future<void> insertAll(String table, List<dynamic> objects) {
    return _appDatabase.insertAll(table, objects);
  }

  @override
  Future<void> runMigrations(List<String> migrations) {
    return _appDatabase.runMigrations(migrations);
  }

  @override
  void close() {
    _appDatabase.close();
  }
}
