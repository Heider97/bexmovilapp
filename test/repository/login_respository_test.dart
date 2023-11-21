import 'package:bexmovil/src/locator.dart';
import 'package:bexmovil/src/services/storage.dart';
import 'package:flutter_test/flutter_test.dart';

//domain
import 'package:bexmovil/src/data/datasources/remote/api_service.dart';
import 'package:bexmovil/src/data/repositories/api_repository_impl.dart';
import 'package:bexmovil/src/domain/repositories/api_repository.dart';

void main() {
  group('Login Repository', () {
    late ApiService apiService;
    late ApiRepository apiRepository;

    setUp(() async {
      TestWidgetsFlutterBinding.ensureInitialized();
      await initializeDependencies(testing: true);
      apiService = ApiService(testing: true);
      apiRepository = ApiRepositoryImpl(apiService);
    });

    group('constructor', () {
      test('instantiates LoginRepository with a required apiService', () {
        expect(apiRepository, isNotNull);
      });
    });

    group(('search next login'), () {
      // test('calls login method', () async {
      //   var goodLoginRequest = LoginRequest(
      //       '000',
      //       '000',
      //       'TP1A.220624.014',
      //       'SM-A035M',
      //       '1.3.120+244',
      //       '2023-11-20 09:28:57',
      //       '6.3242326',
      //       '-75.5692066');
      //   try {
      //     await apiRepository.login(goodLoginRequest);
      //   } catch (_) {}
      //   verify(() => apiService.login(goodLoginRequest)).called(1);
      // });
      //
      // test('throws Result exception when search fails', () async {
      //   var badLoginRequest = LoginRequest(
      //       'no-exist',
      //       'no-exist',
      //       'TP1A.220624.014',
      //       'SM-A035M',
      //       '1.3.120+244',
      //       '2023-11-20 09:28:57',
      //       '6.3242326',
      //       '-75.5692066');
      //   // first create a exception mock instance
      //   final exception = ErrorLogin();
      //   // when calls and api and throw an exception
      //   when(() => apiService.login(badLoginRequest)).thenThrow(exception);
      //   // then expect an error result
      //   expect(() async => apiRepository.login(badLoginRequest),
      //       throwsA(exception));
      // });
    });
  });
}
