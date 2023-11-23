part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  final Login? login;
  final Enterprise? enterprise;
  final String? error;

  const LoginState({this.login, this.enterprise, this.error});

  LoginState copyWith({Enterprise? enterprise}) => LoginInitial(
        enterprise: enterprise ?? this.enterprise,
      );

  @override
  List<Object?> get props => [enterprise, error];
}

class LoginInitial extends LoginState {
  const LoginInitial({super.enterprise});
}

class LoginLoading extends LoginState {
  const LoginLoading({super.enterprise});
}

class LoginSuccess extends LoginState {
  const LoginSuccess({super.login, super.enterprise});
}

class LoginFailed extends LoginState {
  const LoginFailed({super.enterprise, super.error});
}
