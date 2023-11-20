part of 'recovery_password_bloc.dart';

class RecoveryPasswordEvent {
  const RecoveryPasswordEvent();
}

class StartRecovery extends RecoveryPasswordEvent {
  final String type;
  const StartRecovery({required this.type});
}

class RequestCode extends RecoveryPasswordEvent {
  final BuildContext context;
  final String recoveryMethod;
  const RequestCode({required this.recoveryMethod, required this.context});
}

class ValidateCode extends RecoveryPasswordEvent {
  final String? code;
  const ValidateCode({required this.code});
}

class ChangePassword extends RecoveryPasswordEvent {
  const ChangePassword();
}
