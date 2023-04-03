import '../models/processing_queue.dart';
import '../models/category.dart';
import '../models/product.dart';

abstract class DatabaseRepository {

  //DATABASE
  Future<void> init();
  void close();

  //PROCESSING QUEUE
  Future<int> updateProcessingQueue(ProcessingQueue processingQueue);
  Future<void> insertProcessingQueue(ProcessingQueue processingQueue);
  Future<void> emptyProcessingQueues();

  //CATEGORIES
  Future<List<Category>> getAllCategoriesWithProducts();
  Future<Category?> getCategoryWithProducts(int categoryId);
  Future<int> updateCategory(Category category);
  Future<int> insertCategory(Category category);
  Future<void> emptyCategories();

  //PRODUCTS
  Future<List<Product>> getAllProducts();
  Future<int> updateProduct(Product product);
  Future<int> insertProduct(Product product);
  Future<void> insertProducts(List<Product> products);
  Future<void> emptyProducts();


}
