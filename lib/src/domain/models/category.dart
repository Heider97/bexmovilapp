import 'product.dart';

const String tableCategories = 'categories';

class CategoryFields {
  static final List<String> values = [id, name, image];

  static const String id = 'id';
  static const String name = 'name';
  static const String image = 'image';
}

class Category {
  const Category(
      {this.id,
      required this.name,
      required this.image,
      this.products});

  final int? id;
  final String name;
  final String image;
  final List<Product>? products;

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'],
      name: map['name'],
      image: map['image'],
      products: map['products']?.map<Product>((product) => Product.fromMap(product)).toList()
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
    };
  }
}
