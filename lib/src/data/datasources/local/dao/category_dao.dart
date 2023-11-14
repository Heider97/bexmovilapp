/* part of '../app_database.dart';

class CategoryDao {
  final AppDatabase _appDatabase;

  CategoryDao(this._appDatabase);

  List<Category> parseCategories(List<Map<String, dynamic>> categoryList) {
    final categories = <Category>[];
    for (var categoryMap in categoryList) {
      final category = Category.fromMap(categoryMap);
      categories.add(category);
    }
    return categories;
  }

  Future<List<Category>> getAllCategoriesWithProducts() async {
    final db = await _appDatabase.streamDatabase;
    final categoryList = await db!.query(tableCategories);

    if (categoryList.isNotEmpty) {
      var data = <Category>[];
      return Future.forEach(categoryList, (category) async {
        final categoryMap = Map.of(category);
        final products = await db.query(tableProducts, where: 'category_id = ?', whereArgs: [categoryMap['id']], limit: 5, orderBy: 'rating DESC');
        categoryMap['products'] = products;
        data.add(Category.fromMap(categoryMap));
      }).then((_) {
        return data;
      });

    } else {
      return [];
    }
  }

  Future<Category?> getCategoryWithProducts(int categoryId) async {
    final db = await _appDatabase.streamDatabase;
    final categoryList = await db!.query(tableCategories, where: 'id = ?', whereArgs: [categoryId]);

    if (categoryList.isNotEmpty) {
      final categoryMap = Map.of(categoryList[0]);
      final products = await db.query(tableProducts, where: 'category_id = ?', whereArgs: [categoryMap['id']], orderBy: 'rating DESC');
      categoryMap['products'] = products;
      return Category.fromMap(categoryMap);
    } else {
      return null;
    }
  }

  Future<int> insertCategory(Category category) async {
    final db = await _appDatabase.streamDatabase;

    final foundList = await db!.query(tableCategories, where: 'name = ?', whereArgs: [category.name]);

    if (foundList.isNotEmpty) {
      var foundCategory = Category.fromMap(foundList[0]);
      return foundCategory.id!;
    } else {
      return _appDatabase.insert(tableCategories, category.toMap());
    }
  }

  Future<int> updateCategory(Category category) {
    return _appDatabase.update(
        tableCategories, category.toMap(), 'id', category.id!);
  }

  Future<void> emptyCategories() async {
    final db = await _appDatabase.streamDatabase;
    await db!.delete(tableCategories);
    return Future.value();
  }
}
 */