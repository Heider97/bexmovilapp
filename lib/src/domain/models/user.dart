import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String? id;
  final String? email;
  final String? name;
  final String? codbodega;
  final String? consultainventario;

  const User({
    this.id,
    this.email,
    this.name,
    this.codbodega,
    this.consultainventario
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['codvendedor'] != null ? map['codvendedor'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      name: map['nomvendedor'] != null ? map['nomvendedor'] as String : null,
      codbodega: map['codbodega'] != null ? map['codbodega'] as String : null,
      consultainventario: map['consultainventario'] != null ? map['consultainventario'] as String : null,

    );
  }

  Map toMap() {
    return {
      'codvendedor': id,
      'email': email,
      'nomvendedor': name,
      'codbodega': codbodega,
      'consultainventario': consultainventario
    };
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [id, email, name];
}
