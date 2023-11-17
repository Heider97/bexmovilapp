import 'package:equatable/equatable.dart';

class RecoveryCodeResponse extends Equatable {
  final String message;

  const RecoveryCodeResponse({
    required this.message,
  });

  factory RecoveryCodeResponse.fromMap(Map<String, dynamic> map) {
    return RecoveryCodeResponse(
      message: map['message'] != null ? map['message'] as String : '',
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [message];
}
