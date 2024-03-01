const String tableCollections = 'app_collections';

class CollectionFields {
  static final List<String> values = [id, total, client];

  static const String id = 'id';
  static const String total = 'total';
  static const String client = 'client';
}

class Collection {
  int? id;
  double? total;
  String? client;

  Collection({this.id, this.total, this.client});

  factory Collection.fromJson(Map<String, dynamic> json) => Collection(
        id: json["id"],
        total: json["total"],
        client: json["client"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "total": total,
        "client": client,
      };
}
