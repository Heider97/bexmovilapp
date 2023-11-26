import 'package:equatable/equatable.dart';

class ValidateRecoveryCodeResponse extends Equatable {
  final bool status;
  final String message;
  final String? code;

  const ValidateRecoveryCodeResponse(
      {required this.status, required this.message, this.code});

  factory ValidateRecoveryCodeResponse.fromMap(Map<String, dynamic> map) {
    return ValidateRecoveryCodeResponse(
        status: map['status'], message: map['message'], code: map['code']);
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [message];
}
