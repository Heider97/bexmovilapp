import 'package:bexmovil/src/domain/models/feature.dart';
import 'package:equatable/equatable.dart';

class SyncResponse extends Equatable {
  final bool status;
  final String message;
  final List<Feature> features;

  const SyncResponse(
      {required this.status, required this.message, required this.features});

  factory SyncResponse.fromMap(Map<String, dynamic> map) {
    return SyncResponse(
        status: map['status'],
        message: map['message'],
        features: List<Feature>.from(map['features']
            .map((e) => Feature.fromMap(e))));
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [status, message, features];
}
