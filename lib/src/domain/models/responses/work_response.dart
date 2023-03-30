import 'package:equatable/equatable.dart';

import '../work.dart';

class WorkResponse extends Equatable {
  final List<Work> works;

  const WorkResponse({
    required this.works
  });

  factory WorkResponse.fromMap(Map<String, dynamic> map) {
    return WorkResponse(
      works: List<Work>.from(
        map['works'].map<Work>(
          (x) => Work.fromJson(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [works];
}
