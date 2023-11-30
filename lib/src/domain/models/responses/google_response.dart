import '../login.dart';

class GoogleResponse {
  
  final bool status;
  final String message;
  final Login? login;

  const GoogleResponse({
    required this.status,
    required this.message,
    this.login
  });

  factory GoogleResponse.fromMap(Map<String,dynamic>map){
    print(map);

    return GoogleResponse(
      status: map['status'],
      message: map['message'],
      login: Login.fromMap(map)
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [status, message, login!];
}