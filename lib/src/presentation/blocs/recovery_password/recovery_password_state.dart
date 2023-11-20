part of 'recovery_password_bloc.dart';

class RecoveryPasswordState {
  final String? type;
  final String? email;
  final String? phone;
  final String? error;
  final String? pin;
  RecoveryPasswordState(
      {this.type, this.email, this.phone, this.error, this.pin});

  RecoveryPasswordState copyWith(
          {String? type,
          String? email,
          String? phone,
          String? error,
          String? pin}) =>
      RecoveryPasswordState(
          type: type ?? this.type,
          email: email ?? this.email,
          phone: phone ?? this.phone,
          error: error ?? this.error,
          pin: pin ?? this.pin);
}
