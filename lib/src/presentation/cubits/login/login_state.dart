part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  final Enterprise? enterprise;
  final String? error;

  const LoginState({this.enterprise, this.error});

  @override
  List<Object?> get props => [enterprise, error];
}

class LoginLoading extends LoginState {
  const LoginLoading({super.enterprise});
}

class LoginSuccess extends LoginState {
  const LoginSuccess({super.enterprise});
}

class LoginFailed extends LoginState {
  const LoginFailed({super.enterprise, super.error});
}

