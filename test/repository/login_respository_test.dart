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
      test('instantiates LoginRepository with a required apiService', () {
        expect(apiRepository, isNotNull);
      });
    });

    group(('search next login'), () {
      test('calls login method', () async {
        var goodLoginRequest = LoginRequest('000', '000', 'TP1A.220624.014',
            'SM-A035M', '2023-11-20 09:28:57', '6.3242326', '-75.5692066');
        try {
          await apiRepository.login(goodLoginRequest);
        } catch (_) {}
        verify(() => apiService.login(goodLoginRequest)).called(1);
      });

      test('throws Result exception when search fails', () async {
        var badLoginRequest = LoginRequest(
            'no-exist',
            'no-exist',
            'TP1A.220624.014',
            'SM-A035M',
            '2023-11-20 09:28:57',
            '6.3242326',
            '-75.5692066');
        // first create a exception mock instance
        final exception = ErrorLogin();
        // when calls and api and throw an exception
        when(() => apiService.login(badLoginRequest)).thenThrow(exception);
        // then expect an error result
        expect(() async => apiRepository.login(badLoginRequest),
            throwsA(exception));
      });
    });
  });
}
