import 'package:bexmovil/src/domain/models/requests/sync_request.dart';

import '../../utils/resources/data_state.dart';

import '../models/requests/enterprise_request.dart';
import '../models/responses/enterprise_response.dart';

import '../models/requests/login_request.dart';
import '../models/responses/login_response.dart';

import '../models/requests/database_request.dart';
import '../models/responses/database_response.dart';

import '../models/requests/enterprise_config_request.dart';
import '../models/responses/enterprise_config_response.dart';
import '../models/responses/sync_response.dart';

abstract class ApiRepository {
  Future<DataState<EnterpriseResponse>> getEnterprise({
    required EnterpriseRequest request,
  });

  Future<DataState<EnterpriseConfigResponse>> getConfigEnterprise({
    required EnterpriseConfigRequest request,
  });

  Future<DataState<LoginResponse>> login({
    required LoginRequest request,
  });

  Future<DataState<SyncResponse>> syncfeatures({
    required SyncRequest request
  });

  Future<DataState<DatabaseResponse>> database(
      {required DatabaseRequest request});
}
