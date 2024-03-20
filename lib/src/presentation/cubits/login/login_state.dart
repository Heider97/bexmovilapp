part of 'login_cubit.dart';

enum LoginStatus { initial, loading, success, failure }

extension LoginStatusX on LoginStatus {
  bool get isInitial => this == LoginStatus.initial;
  bool get isLoading => this == LoginStatus.loading;
  bool get isSuccess => this == LoginStatus.success;
  bool get isFailure => this == LoginStatus.failure;
}

abstract class LoginState extends Equatable {
  final Login? login;
  final Enterprise? enterprise;
  final String? error;
  final LoginStatus? status;

  const LoginState({this.login, this.enterprise, this.status, this.error});

  @override
  List<Object?> get props => [login, enterprise, status, error];
}

class LoginInitial extends LoginState {
  const LoginInitial({super.status = LoginStatus.initial, super.enterprise});
}

class LoginLoading extends LoginState {
  const LoginLoading({super.status = LoginStatus.loading, super.enterprise});
}

class LoginSuccess extends LoginState {
  const LoginSuccess({super.status = LoginStatus.success, super.login, super.enterprise});
}

class LoginFailed extends LoginState {
  const LoginFailed({super.status = LoginStatus.failure, super.enterprise, super.error});
}
