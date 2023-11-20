import 'package:bexmovil/src/domain/models/requests/login_request.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';


import '../data/api_repository.dart';
import '../data/api_service.dart';

import '../utils/errors.dart';

class MockService extends Mock implements TestApiService {}

void main() {
  group('Login Repository', () {
    late TestApiService apiService;
    late ApiRepository apiRepository;

    setUp(() {
      apiService = MockService();
      apiRepository = ApiRepository(service: apiService);
    });

    group('constructor', () {
      test('instantiates LoginRepository with a required carService', () {
        expect(apiRepository, isNotNull);
      });
    });

    group(('search next login'), () {
      test('calls search method', () async {
        try {
          await apiRepository.login(LoginRequest(
              '000',
              '000',
              'TP1A.220624.014',
              'SM-A035M',
              '2023-11-20 09:28:57',
              '6.3242326',
              '-75.5692066'));
        } catch (_) {}
        verify(() => apiService.login(null)).called(1);
      });

      test('throws Result exception when search fails', () async {
        // first create a exception mock instance
        final exception = ErrorLogin();
        // when calls and api and throw an exception
        when(() => apiService.login(null)).thenThrow(exception);
        // then expect an error result
        expect(() async => apiRepository.login(LoginRequest(
            'no-exist',
            'no-exist',
            'TP1A.220624.014',
            'SM-A035M',
            '2023-11-20 09:28:57',
            '6.3242326',
            '-75.5692066')), throwsA(exception));
      });
    });
  });
}
