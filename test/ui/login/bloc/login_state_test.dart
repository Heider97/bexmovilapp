import 'package:flutter_test/flutter_test.dart';
//cubit
import 'package:bexmovil/src/presentation/cubits/login/login_cubit.dart';

void main() {
  group('LoginStatus', () {
    test('returns correct values for LoginStatus.initial', () {
      const status = LoginStatus.initial;

      expect(status.isInitial, isTrue);
      expect(status.isLoading, isFalse);
      expect(status.isSuccess, isFalse);
      expect(status.isFailure, isFalse);
    });

    test('returns correct values for LoginStatus.loading', () {
      const status = LoginStatus.loading;

      expect(status.isInitial, isFalse);
      expect(status.isLoading, isTrue);
      expect(status.isSuccess, isFalse);
      expect(status.isFailure, isFalse);
    });

    test('returns correct values for LoginStatus.isSuccess', () {
      const status = LoginStatus.success;
      expect(status.isInitial, isFalse);
      expect(status.isLoading, isFalse);
      expect(status.isSuccess, isTrue);
      expect(status.isFailure, isFalse);
    });

    test('returns correct values for LoginStatus.isFailure', () {
      const status = LoginStatus.failure;
      expect(status.isInitial, isFalse);
      expect(status.isLoading, isFalse);
      expect(status.isSuccess, isFalse);
      expect(status.isFailure, isTrue);
    });

  });
}