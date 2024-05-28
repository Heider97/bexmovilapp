//TODO: [Heider Zapa] organize
import 'package:bexmovil/src/domain/models/requests/change_password_request.dart';
import 'package:bexmovil/src/domain/models/requests/client_location_request.dart';
import 'package:bexmovil/src/domain/models/requests/recovery_code_request.dart';
import 'package:bexmovil/src/domain/models/requests/validate_code_request.dart';
import 'package:bexmovil/src/domain/models/responses/change_password_response.dart';
import 'package:bexmovil/src/domain/models/responses/recovery_code_response.dart';
import 'package:bexmovil/src/domain/models/responses/validate_recovery_code_response.dart';
import 'package:bexmovil/src/domain/models/responses/nearby_places_response.dart';

import '../../utils/resources/data_state.dart';

import '../models/requests/dynamic_request.dart';
import '../models/requests/google_request.dart';
import '../models/requests/google_maps_request.dart';
import '../models/requests/functionality_request.dart';
import '../models/requests/enterprise_request.dart';
import '../models/requests/graphic_request.dart';
import '../models/requests/kpi_request.dart';
import '../models/requests/module_request.dart';
import '../models/requests/sync_priorities_request.dart';
import '../models/responses/dynamic_response.dart';
import '../models/responses/enterprise_response.dart';
import '../models/responses/graphic_response.dart';
import '../models/requests/filter_request.dart';

import '../models/requests/login_request.dart';
import '../models/responses/kpi_response.dart';
import '../models/responses/login_response.dart';
import '../models/responses/functionality_response.dart';
import '../models/responses/filter_response.dart';

import '../models/responses/config_response.dart';
import '../models/responses/module_response.dart';
import '../models/responses/sync_priorities_response.dart';
import '../models/responses/sync_response.dart';

abstract class ApiRepository {
  Future<DataState<EnterpriseResponse>> getEnterprise({
    required EnterpriseRequest request,
  });

  Future<DataState<ConfigResponse>> configs();

  Future<DataState<SyncResponse>> features();

  Future<DataState<LoginResponse>> login({
    required LoginRequest request,
  });

  Future<DataState<RecoveryCodeResponse>> requestRecoveryCode(
      {required RecoveryCodeRequest request});

  Future<DataState<ValidateRecoveryCodeResponse>> validateRecoveryCode(
      {required ValidateCodeRequest request});

  Future<DataState<ChangePasswordResponse>> changePassword(
      {required ChangePasswordRequest request});

  Future<DataState<SyncPrioritiesResponse>> priorities(
      {required SyncPrioritiesRequest request});

  Future<DataState<ModuleResponse>> modules({required ModuleRequest request});

  Future<DataState<DynamicResponse>> syncDynamic(
      {required DynamicRequest request});

  Future<DataState<DynamicTablesResponse>> syncDynamicMultiTables(
      {required DynamicRequestMultitable request});

  Future<DataState<KpiResponse>> kpis({required KpiRequest request});

/*   Future<DataState<ClientLocationResponse>> clientLocation(
      {required ClientLocationRequest request}); */

  Future<DataState<FunctionalityResponse>> functionalities(
      {required FunctionalityRequest request});

  Future<DataState<GraphicResponse>> graphics(
      {required GraphicRequest request});

  Future<DataState<FilterResponse>> filters({required FilterRequest request});

  Future<DataState<NearbyPlacesResponse>> places(
      {required GoogleMapsRequest request});
}
