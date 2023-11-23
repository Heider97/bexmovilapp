import 'package:flutter_test/flutter_test.dart';
import 'package:bexmovil/src/presentation/cubits/login/login_cubit.dart';

void main() {
  group('LoginStatus', () {
    test('returns correct values for LoginStatus.initial', () {
      const status = LoginInitial;
      expect(status is LoginInitial, isTrue);
      expect(status is LoginLoading, isFalse);
      expect(status is LoginSuccess, isFalse);
      expect(status is LoginFailed, isFalse);
    });

    test('returns correct values for LoginStatus.loading', () {
      const status = LoginLoading;
      expect(status is LoginInitial, isFalse);
      expect(status is LoginLoading, isTrue);
      expect(status is LoginSuccess, isFalse);
      expect(status is LoginFailed, isFalse);
    });

    test('returns correct values for LoginStatus.isSuccess', () {
      const status = LoginSuccess;
      expect(status is LoginInitial, isFalse);
      expect(status is LoginLoading, isFalse);
      expect(status is LoginSuccess, isTrue);
      expect(status is LoginFailed, isFalse);
    });

    test('returns correct values for LoginStatus.isFailure', () {
      const status = LoginFailed;
      expect(status is LoginInitial, isFalse);
      expect(status is LoginLoading, isFalse);
      expect(status is LoginSuccess, isFalse);
      expect(status is LoginFailed, isTrue);
    });

  });
}