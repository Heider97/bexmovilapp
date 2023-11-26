import 'package:flutter_test/flutter_test.dart';

//domain
import 'package:bexmovil/src/domain/models/requests/login_request.dart';
import 'package:bexmovil/src/domain/models/responses/login_response.dart';
import 'package:bexmovil/src/domain/repositories/api_repository.dart';

//utils
import 'package:bexmovil/src/utils/resources/data_state.dart';

class MockApiRepository extends Fake implements ApiRepository {
  DataState<LoginResponse> fakeGoodLoginResponse =
      const DataSuccess(LoginResponse(status: true, message: 'successful'));

  DataState<LoginResponse> fakeBadLoginResponse =
      const DataFailed('Unexpected error occurred');

  @override
  Future<DataState<LoginResponse>> login(
      {required LoginRequest request}) async {
    if (request.username == "no-exist" && request.password == "no-exist") {
      return fakeBadLoginResponse;
    }

    return fakeGoodLoginResponse;
  }
}
