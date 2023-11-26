import 'package:equatable/equatable.dart';

import '../enterprise.dart';

class EnterpriseResponse extends Equatable {
  final bool status;
  final String message;
  final Enterprise enterprise;

  const EnterpriseResponse({
    required this.status,
    required this.message,
    required this.enterprise,
  });

  factory EnterpriseResponse.fromMap(Map<String, dynamic> map) {
    return EnterpriseResponse(
      status: map['status'],
      message: map['message'],
      enterprise: Enterprise.fromMap(map['enterprise']),
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [status, message , enterprise];
}