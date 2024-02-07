import 'package:equatable/equatable.dart';

import '../kpi.dart';

class KpiResponse extends Equatable {
  final bool status;
  final String message;
  final List<Kpi> kpis;

  const KpiResponse({
    required this.status,
    required this.message,
    required this.kpis,
  });

  factory KpiResponse.fromMap(Map<String, dynamic> map) {
    return KpiResponse(
      status: map['status'],
      message: map['message'],
      kpis: List<Kpi>.from(map['kpis'].map((e) => Kpi.fromJson(e))),
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [status, message, kpis];
}
