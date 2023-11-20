import 'package:bexmovil/src/domain/models/requests/login_request.dart';
import 'package:bexmovil/src/domain/models/responses/login_response.dart';

import 'api_service.dart';

class ApiRepository {
  const ApiRepository({required this.service});
  final TestApiService service;

  Future<LoginResponse> login(LoginRequest request) async => service.login(request);
}