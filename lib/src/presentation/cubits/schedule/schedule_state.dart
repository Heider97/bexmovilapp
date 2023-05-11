part of 'schedule_cubit.dart';

class ScheduleState extends Equatable {

  final String? error;

  const ScheduleState({ this.error });

  @override
  List<Object?> get props => [error];

}

class ScheduleLoading extends ScheduleState {
  const ScheduleLoading();
}

class ScheduleSuccess extends ScheduleState {
  const ScheduleSuccess();
}

class ScheduleFailed extends ScheduleState {
  const ScheduleFailed({super.error});
}
