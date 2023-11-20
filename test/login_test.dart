import 'package:bexmovil/src/core/functions.dart';
import 'package:bexmovil/src/domain/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

//utils
import 'package:bexmovil/src/utils/resources/data_state.dart';
//login
import 'package:bexmovil/src/domain/models/requests/login_request.dart';
//repository
import 'package:bexmovil/src/domain/repositories/api_repository.dart';
import 'package:bexmovil/src/domain/repositories/database_repository.dart';
//model
import 'package:bexmovil/src/domain/models/login.dart';
//ui
import 'package:bexmovil/src/presentation/views/global/login_view.dart';

//services
import 'package:bexmovil/src/locator.dart';
import 'package:intl/intl.dart';
import 'package:location_repository/location_repository.dart';

final ApiRepository _apiRepository = locator<ApiRepository>();
final DatabaseRepository _databaseRepository = locator<DatabaseRepository>();
final LocationRepository _locationRepository = locator<LocationRepository>();
final _helperFunction = HelperFunctions();

void main() {
  group('Test login data, domain, ui', () {
    WidgetsFlutterBinding.ensureInitialized();
    Future.value(initializeDependencies());

    //DATA
    test('value should has api', () async {
      var location = await _locationRepository.getCurrentLocation();
      var device = await _helperFunction.getDevice();

      var goodResponse = await _apiRepository.login(
          request: LoginRequest(
              '000',
              '000',
              device!['id'],
              device['model'],
              DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
              location.latitude.toString(),
              location.longitude.toString()));

      expect(goodResponse, DataSuccess);

      var badResponse = await _apiRepository.login(
          request: LoginRequest('not-exist', 'no-exist', device!['id'],
              device['model'],
              DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
              location.latitude.toString(),
              location.longitude.toString()));

      expect(badResponse, DataFailed);
    });

    test('value has model data', () {
      const login = Login(
          user: User(email: 'test@gmail.com', name: 'Test', username: '000'),
          token: '1234567890');

      // counter.increment();
      //
      // expect(counter.value, 1);
    });

    //DOMAIN

    //UI
    testWidgets('value should has ui', (WidgetTester tester) async {
      // await tester.pumpWidget(const LoginView());
    });
  });
}
