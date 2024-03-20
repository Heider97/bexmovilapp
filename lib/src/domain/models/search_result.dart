class SearchResult {
  String? type;
  String? image;
  String? name;
  dynamic code;
  int? unitOfSale;
  double? price;
  String? codUnidadEmp;

  // Constructor
  SearchResult(
      {this.type,
      this.image,
      this.name,
      this.code,
      this.unitOfSale,
      this.price,
      this.codUnidadEmp});

  // Factory method to create a Product instance from a JSON map
  factory SearchResult.fromJson(Map<String, dynamic> json, String tableName) {
    return SearchResult(
      type: tableName.substring(4),
      image: json['IMAGEN'] as String?,

      name: json['NOM${tableName.substring(4).toUpperCase()}'] as String?,
      code: json['COD${tableName.substring(4).toUpperCase()}'],
      unitOfSale:
          json['unidadventa'] != null ? json['unidadventa'] as int? : null,
      codUnidadEmp:
          json['codunidademp'] != null ? json['codunidademp'] as String? : null,
      //TO BE DEFINED PRICE NO EXIST IN DATABASE.
      // price: (json['price'] as num?)?.toDouble(),
    );
  }

  // Convert the Product instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'image': image,
      'name': name,
      'code': code,
      'unitOfSale': unitOfSale,
      'price': price,
    };
  }
}
