import 'package:equatable/equatable.dart';

class User extends Equatable {

  final int? id;
  final String? email;
  final String? name;

  const User({
    this.id,
    this.email,
    this.name,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id : map['codvendedor'] != null ? map['codvendedor'] as int : null,
      email : map['email'] != null ? map['email'] as String : null,
      name : map['nomvendedor'] != null ? map['nomvendedor'] as String : null,
    );
  }

  Map toMap(){
    return  {
      'id': id,
      'email': email,
      'name': name,
    };
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [id, email, name];
}
