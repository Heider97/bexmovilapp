import 'package:equatable/equatable.dart';

import '../login.dart';

class LoginResponse extends Equatable {
  final bool status;
  final String message;
  final Login? login;

  const LoginResponse({
    required this.status,
    required this.message,
    this.login
  });

  factory LoginResponse.fromMap(Map<String, dynamic> map) {

    print(map);

    return LoginResponse(
      status: map['status'],
      message: map['message'],
      login: Login.fromMap(map),
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [status, message, login!];
}