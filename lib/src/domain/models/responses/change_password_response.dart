import 'package:equatable/equatable.dart';

class ChangePasswordResponse extends Equatable {
  final bool status;
  final String message;

  const ChangePasswordResponse({required this.status, required this.message});

  factory ChangePasswordResponse.fromMap(Map<String, dynamic> map) {
    return ChangePasswordResponse(
        status: map['status'], message: map['message']);
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [message];
}
