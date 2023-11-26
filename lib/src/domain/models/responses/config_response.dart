import 'package:equatable/equatable.dart';

import '../config.dart';

class ConfigResponse extends Equatable {
  final bool status;
  final String message;
  final List<Config> configs;

  const ConfigResponse({
    required this.status,
    required this.message,
    required this.configs,
  });

  factory ConfigResponse.fromMap(Map<String, dynamic> map) {
    return ConfigResponse(
      status: map['status'],
      message: map['message'],
      configs: List<Config>.from(
          map['configs'].map((e) => Config.fromMap(e))),
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [status, message, configs];
}
