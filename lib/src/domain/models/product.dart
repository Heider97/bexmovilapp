class Product {
  DateTime? lastSoldOn;
  int? lastQuantitySold;
  String code;
  String name;
  double sellingPrice;
  double discount;
  int availableUnits;
  int quantity;
  OriginLocation originLocation;

  Product({
    this.lastSoldOn,
    this.lastQuantitySold,
    required this.code,
    required this.name,
    required this.sellingPrice,
    required this.discount,
    required this.availableUnits,
    required this.quantity,
    required this.originLocation,
  });
}

class OriginLocation {
  String name;
  int availableQuantity;
  bool isSelected;

  OriginLocation({
    required this.name,
    required this.availableQuantity,
    required this.isSelected,
  });
}
