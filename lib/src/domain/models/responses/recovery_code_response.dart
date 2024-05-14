import 'package:equatable/equatable.dart';

class RecoveryCodeResponse extends Equatable {
  final bool status;
  final String message;

  const RecoveryCodeResponse({
    required this.status,
    required this.message,
  });

  factory RecoveryCodeResponse.fromMap(Map<String, dynamic> map) {
    return RecoveryCodeResponse(
      status: map['status'],
      message: map['message'],
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [message];
}
