//utils
import '../../utils/resources/data_state.dart';
import '../datasources/remote/api_service.dart';
import 'base/base_api_repository.dart';

//requests
import '../../domain/models/requests/enterprise_request.dart';
import '../../domain/models/requests/login_request.dart';
import '../../domain/models/requests/change_password_request.dart';
import '../../domain/models/requests/sync_priorities_request.dart';
import '../../domain/models/requests/functionality_request.dart';
import '../../domain/models/requests/dynamic_request.dart';
import '../../domain/models/requests/google_request.dart';
import '../../domain/models/requests/graphic_request.dart';
import '../../domain/models/requests/filter_request.dart';
import '../../domain/models/requests/google_maps_request.dart';

//responses
import '../../domain/models/responses/enterprise_response.dart';
import '../../domain/models/responses/recovery_code_response.dart';
import '../../domain/models/responses/validate_recovery_code_response.dart';
import '../../domain/models/responses/change_password_response.dart';
import '../../domain/models/responses/login_response.dart';
import '../../domain/models/responses/dynamic_response.dart';
import '../../domain/models/responses/google_response.dart';
import '../../domain/models/responses/sync_priorities_response.dart';
import '../../domain/models/responses/sync_response.dart';
import '../../domain/models/responses/functionality_response.dart';
import '../../domain/models/responses/graphic_response.dart';
import '../../domain/models/responses/filter_response.dart';
import '../../domain/models/responses/nearby_places_response.dart';

import '../../domain/models/responses/config_response.dart';
import '../../domain/models/requests/kpi_request.dart';
import '../../domain/models/responses/kpi_response.dart';
//repository
import '../../domain/repositories/api_repository.dart';

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
  Future<DataState<GoogleResponse>> googleCount(
      {required GoogleRequest request}) {
    return getStateOf<GoogleResponse>(request: () => _apiService.googleCount());
  }

  @override
  Future<DataState<NearbyPlacesResponse>> places(
      {required GoogleMapsRequest request}) {
    return getStateOf<NearbyPlacesResponse>(
        request: () => _apiService.places(request: request));
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
      request: () => _apiService.syncDynamic(
          table: request.table, content: request.content),
    );
  }

  @override
  Future<DataState<KpiResponse>> kpis({required KpiRequest request}) {
    return getStateOf<KpiResponse>(
      request: () => _apiService.kpis(codvendedor: request.codvendedor),
    );
  }

  @override
  Future<DataState<FunctionalityResponse>> functionalities(
      {required FunctionalityRequest request}) {
    return getStateOf<FunctionalityResponse>(
      request: () =>
          _apiService.functionalities(codvendedor: request.codvendedor),
    );
  }

  @override
  Future<DataState<FilterResponse>> filters({required FilterRequest request}) {
    return getStateOf<FilterResponse>(
      request: () => _apiService.filters(codvendedor: request.codvendedor),
    );
  }

  @override
  Future<DataState<GraphicResponse>> graphics(
      {required GraphicRequest request}) {
    return getStateOf<GraphicResponse>(
      request: () => _apiService.graphics(codvendedor: request.codvendedor),
    );
  }
}
