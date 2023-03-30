import '../../domain/models/requests/login_request.dart';
import '../../domain/models/responses/login_response.dart';

import '../../domain/models/requests/enterprise_request.dart';
import '../../domain/models/responses/enterprise_response.dart';

import '../../domain/models/requests/work_request.dart';
import '../../domain/models/responses/work_response.dart';

import '../../domain/models/requests/database_request.dart';
import '../../domain/models/responses/database_response.dart';

import '../../domain/models/requests/enterprise_config_request.dart';
import '../../domain/models/responses/enterprise_config_response.dart';

import '../../domain/models/requests/reason_request.dart';
import '../../domain/models/responses/reason_response.dart';

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
      request: () => _apiService.getEnterprise(),
    );
  }

  @override
  Future<DataState<EnterpriseConfigResponse>> getConfigEnterprise({
    required EnterpriseConfigRequest request,
  }) {
    return getStateOf<EnterpriseConfigResponse>(
      request: () => _apiService.getConfigEnterprise(),
    );
  }

  @override
  Future<DataState<ReasonResponse>> reasons({
    required ReasonRequest request,
  }) {
    return getStateOf<ReasonResponse>(
      request: () => _apiService.reasons(),
    );
  }

  @override
  Future<DataState<LoginResponse>> login({
    required LoginRequest request,
  }) {
    return getStateOf<LoginResponse>(
      request: () => _apiService.login(
        username: request.username,
        password: request.password
      ),
    );
  }

  @override
  Future<DataState<WorkResponse>> works({
    required WorkRequest request,
  }) {
    return getStateOf<WorkResponse>(
      request: () => _apiService.works(
          id: request.id,
          udid: request.udid,
          model: request.model,
          version: request.version,
          latitude: request.latitude,
          longitude: request.longitude,
          date: request.date,
          from: request.from
      ),
    );
  }

  @override
  Future<DataState<DatabaseResponse>> database({
    required DatabaseRequest request,
  }) {
    return getStateOf<DatabaseResponse>(
      request: () => _apiService.database(
          path: request.path
      ),
    );
  }
}