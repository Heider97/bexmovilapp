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
  final BuildContext context;
  final String code;
  const ValidateCode({required this.code, required this.context});
}

class ChangePassword extends RecoveryPasswordEvent {
  final BuildContext context;
  final String password;
  final String confirmPassword;
  const ChangePassword(
      {required this.password,
      required this.confirmPassword,
      required this.context});
}

class ClearErrors extends RecoveryPasswordEvent {
  const ClearErrors();
}

class RetryCode extends RecoveryPasswordEvent {
  final String recoveryMethod;
  const RetryCode({required this.recoveryMethod});
}
