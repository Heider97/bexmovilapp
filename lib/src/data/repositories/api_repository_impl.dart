import 'package:bexmovil/src/domain/models/requests/sync_priorities_request.dart';

import 'package:bexmovil/src/domain/models/responses/sync_priorities_response.dart';

import '../../domain/models/requests/login_request.dart';
import '../../domain/models/responses/login_response.dart';

import '../../domain/models/requests/enterprise_request.dart';
import '../../domain/models/responses/enterprise_response.dart';

import '../../domain/models/requests/database_request.dart';
import '../../domain/models/responses/database_response.dart';

import '../../domain/models/requests/enterprise_config_request.dart';
import '../../domain/models/responses/enterprise_config_response.dart';

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
  Future<DataState<EnterpriseConfigResponse>> getConfigEnterprise({
    required EnterpriseConfigRequest request,
  }) {
    return getStateOf<EnterpriseConfigResponse>(
      request: () => _apiService.getConfigEnterprise(),
    );
  }

  @override
  Future<DataState<LoginResponse>> login({
    required LoginRequest request,
  }) {
    return getStateOf<LoginResponse>(
      request: () => _apiService.login(
          username: request.username,
          password: request.password,
          deviceId: request.deviceId,
          model: request.model,
          date: request.date,
          latitude: request.latitude,
          longitude: request.longitude),
    );
  }

  @override
  Future<DataState<DatabaseResponse>> database({
    required DatabaseRequest request,
  }) {
    return getStateOf<DatabaseResponse>(
      request: () => _apiService.database(path: request.path),
    );
  }

  @override
  Future<DataState<SyncPrioritiesResponse>> syncPriorities(
      {required SyncPrioritiesRequest request}) {
    return getStateOf<SyncPrioritiesResponse>(
      request: () =>
          _apiService.syncPriorities(count: request.count, date: request.date),
    );
  }
}
