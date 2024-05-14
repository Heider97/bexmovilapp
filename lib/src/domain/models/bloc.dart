const String tableBlocs = 'app_blocs';

class BlocFields {
  static final List<String> values = [id, name, createdAt];

  static const String id = 'id';
  static const String name = 'name';
  static const String createdAt = 'created_at';
}

class Bloc {
  int? id;
  String? name;
  String? createdAt;

  Bloc({
    this.id,
    this.name,
    this.createdAt,
  });

  factory Bloc.fromJson(Map<String, dynamic> json) => Bloc(
        id: json['id'],
        name: json['name'],
        createdAt: json['created_at'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'created_at': createdAt,
      };
}
