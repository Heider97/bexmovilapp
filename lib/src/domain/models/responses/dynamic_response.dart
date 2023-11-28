import 'package:equatable/equatable.dart';

class DynamicResponse extends Equatable {
  final bool status;
  final String message;
  final List<Map<String, dynamic>>? data;

  const DynamicResponse({
    required this.status,
    required this.message,
    this.data
  });

  factory DynamicResponse.fromMap(Map<String, dynamic> map, String table) {
    return DynamicResponse(
      status: map['status'],
      message: map['message'],
      data : map[table],
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [status, message, data!];
}
