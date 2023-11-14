/* import 'package:equatable/equatable.dart';

import '../product.dart';

class DummyResponse extends Equatable {
  final int total, skip, limit;
  final List<Product> products;

  const DummyResponse({
    required this.skip,
    required this.limit,
    required this.total,
    required this.products,
  });

  factory DummyResponse.fromMap(Map<String, dynamic> map) {
    return DummyResponse(
      limit: (map['limit'] ?? 0) as int,
      skip: (map['skip'] ?? 0) as int,
      total: (map['total'] ?? 0) as int,
      products: List<Product>.from(
        map['products'].map<Product>(
              (x) => Product.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [limit, total, skip, products];
} */