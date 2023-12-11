import 'package:bexmovil/src/domain/models/requests/sync_request.dart';
import 'package:bexmovil/src/domain/models/responses/sync_response.dart';

import 'package:bexmovil/src/domain/models/requests/change_password_request.dart';
import 'package:bexmovil/src/domain/models/requests/recovery_code_request.dart';
import 'package:bexmovil/src/domain/models/requests/validate_code_request.dart';
import 'package:bexmovil/src/domain/models/responses/change_password_response.dart';

import 'package:bexmovil/src/domain/models/responses/recovery_code_response.dart';
import 'package:bexmovil/src/domain/models/responses/validate_recovery_code_response.dart';

import '../../domain/models/requests/dynamic_request.dart';
import '../../domain/models/requests/login_request.dart';
import '../../domain/models/requests/sync_priorities_request.dart';
import '../../domain/models/responses/dynamic_response.dart';
import '../../domain/models/responses/login_response.dart';

import '../../domain/models/requests/enterprise_request.dart';
import '../../domain/models/responses/enterprise_response.dart';

import '../../domain/models/responses/config_response.dart';

import '../../domain/models/responses/sync_priorities_response.dart';
import '../../domain/repositories/api_repository.dart';
import '../../utils/resources/data_state.dart';
import '../datasources/remote/api_service.dart';
import 'base/base_api_repository.dart';

class ApiRepositoryImpl extends BaseApiRepository implements ApiRepository {
  final ApiService _apiService;

  ApiRepositoryImpl(this._apiService);

  @override
  Future<DataState<EnterpriseResponse>> getEnterprise({
    required EnterpriseRequest request,
  }) {
    return getStateOf<EnterpriseResponse>(
      request: () => _apiService.getEnterprise(request.company),
    );
  }

  @override
  Future<DataState<ConfigResponse>> configs() {
    return getStateOf<ConfigResponse>(request: () => _apiService.configs());
  }

  @override
  Future<DataState<LoginResponse>> login({
    required LoginRequest request,
  }) {
    return getStateOf<LoginResponse>(
        request: () => _apiService.login(loginRequest: request));
  }

  @override
  Future<DataState<SyncResponse>> features() {
    return getStateOf<SyncResponse>(
      request: () => _apiService.features(),
    );
  }

  @override
  Future<DataState<RecoveryCodeResponse>> requestRecoveryCode(
      {required request}) {
    return getStateOf<RecoveryCodeResponse>(
      request: () => _apiService.requestRecoveryCode(email: request.email),
    );
  }

  @override
  Future<DataState<ValidateRecoveryCodeResponse>> validateRecoveryCode(
      {required request}) {
    return getStateOf<ValidateRecoveryCodeResponse>(
      request: () => _apiService.validateRecoveryCode(code: request.code),
    );
  }

  @override
  Future<DataState<ChangePasswordResponse>> changePassword(
      {required ChangePasswordRequest request}) {
    return getStateOf<ChangePasswordResponse>(
      request: () => _apiService.changePassword(
          code: request.code, password: request.password),
    );
  }

  @override
  Future<DataState<SyncPrioritiesResponse>> priorities(
      {required SyncPrioritiesRequest request}) {
    return getStateOf<SyncPrioritiesResponse>(
      request: () =>
          _apiService.priorities(version: request.version, date: request.date),
    );
  }


  @override
  Future<DataState<DynamicResponse>> syncDynamic(
      {required DynamicRequest request}) {
    return getStateOf<DynamicResponse>(
      request: () => _apiService.syncDynamic(table: request.table),
    );
  }
}
