import 'package:flutter_test/flutter_test.dart';

//domain
import 'package:bexmovil/src/domain/models/requests/login_request.dart';
import 'package:bexmovil/src/domain/models/responses/login_response.dart';
import 'package:bexmovil/src/domain/repositories/api_repository.dart';

//utils
import 'package:bexmovil/src/utils/resources/data_state.dart';

class MockApiRepository extends Fake implements ApiRepository {
  DataState<LoginResponse> fakeLoginResponse =
      const DataSuccess(LoginResponse(status: true, message: 'successful'));

  @override
  Future<DataState<LoginResponse>> login(
      {required LoginRequest request}) async {
    return fakeLoginResponse;
  }
}
