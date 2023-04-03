import '../../domain/repositories/database_repository.dart';
import '../datasources/local/app_database.dart';

//models
import '../../domain/models/processing_queue.dart';
import '../../domain/models/category.dart';
import '../../domain/models/product.dart';

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

  //CATEGORIES
  @override
  Future<List<Category>> getAllCategoriesWithProducts() async {
    return _appDatabase.categoryDao.getAllCategoriesWithProducts();
  }

  @override
  Future<int> updateCategory(Category category) async {
    return _appDatabase.categoryDao.updateCategory(category);
  }

  @override
  Future<int> insertCategory(Category category) async {
    return _appDatabase.categoryDao.insertCategory(category);
  }

  @override
  Future<void> emptyCategories() async {
    return _appDatabase.categoryDao.emptyCategories();
  }

  //PRODUCTS
  @override
  Future<List<Product>> getAllProducts() async {
    return _appDatabase.productDao.getAllProducts();
  }

  @override
  Future<int> updateProduct(Product product) async {
    return _appDatabase.productDao.updateProduct(product);
  }

  @override
  Future<int> insertProduct(Product product) async {
    return _appDatabase.productDao.insertProduct(product);
  }

  @override
  Future<void> insertProducts(List<Product> products) async {
    return _appDatabase.productDao.insertProducts(products);
  }

  @override
  Future<void> emptyProducts() async {
    return _appDatabase.productDao.emptyProducts();
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
