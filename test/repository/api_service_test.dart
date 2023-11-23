// http_server_test.dart:
import 'package:bexmovil/src/domain/models/responses/login_response.dart';
import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

//datasource
import 'package:bexmovil/src/data/datasources/remote/api_service.dart';


@GenerateNiceMocks([MockSpec<ApiService>()])
import 'api_service_test.mocks.dart';

void main() {
  late MockApiService apiService;

  setUpAll(() {
    apiService = MockApiService();
  });

  // group('ApiService', () {
  //   test('Test login 200 response', () async {
  //     final response = await apiService.login();
  //
  //     expect(response, );
  //
  //   });
  // });

}