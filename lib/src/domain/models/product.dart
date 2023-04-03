const String tableProducts = 'products';

class ProductFields {
  static final List<String> values = [id, name, description, price, image, categoryId];

  static const String id = 'id';
  static const String name = 'name';
  static const String description = 'description';
  static const String price = 'price';
  static const String image = 'image';
  static const String categoryId = 'category_id';
}

class Product {
  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    this.categoryId,
  });

  final int id;
  final String name;
  final String description;
  final double price;
  final String image;
  final int? categoryId;

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id : map['id'],
      name : map['name'],
      description : map['description'],
      price : map['price'] is String ? double.parse(map['price']) : map['price'],
      image : map['image'],
      categoryId : map['category_id'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'image': image,
      'category_id' : categoryId
    };
  }
}
