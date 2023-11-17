part of 'recovery_password_bloc.dart';

class RecoveryPasswordState {
  const RecoveryPasswordState();
}

class RecoveryPasswordInitial extends RecoveryPasswordState {}

class StartRecoveryState extends RecoveryPasswordState {
  final String type;
  const StartRecoveryState({required this.type});
}

class RecoveryPasswordLoading extends RecoveryPasswordState {
  const RecoveryPasswordLoading();
}

class RecoveryPasswordError extends RecoveryPasswordState {
  final String? message;
  const RecoveryPasswordError(this.message);
}
