import 'package:equatable/equatable.dart';

class Enterprise extends Equatable {
  final String? name;
  final String? logo;

  const Enterprise({
    required this.name,
    this.logo,
  });

  factory Enterprise.fromMap(Map<String, dynamic> map) {
    return Enterprise(
      name: map['fqdn'] != null
          ? map['fqdn'] as String
          : map['name'],
      logo: map['website'] != null
          ? map['website']['logo'] as String
          : map['logo'],
    );
  }

  Map toMap() {
    return {
      'name': name,
      'logo': logo,
    };
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [name, logo];
}
