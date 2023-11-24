import 'package:bexmovil/src/domain/models/requests/change_password_request.dart';
import 'package:bexmovil/src/domain/models/requests/recovery_code_request.dart';
import 'package:bexmovil/src/domain/models/requests/validate_code_request.dart';
import 'package:bexmovil/src/domain/models/responses/change_password_response.dart';
import 'package:bexmovil/src/domain/models/responses/recovery_code_response.dart';
import 'package:bexmovil/src/domain/models/responses/validate_recovery_code_response.dart';

import '../../utils/resources/data_state.dart';

import '../models/requests/enterprise_request.dart';
import '../models/responses/enterprise_response.dart';

import '../models/requests/login_request.dart';
import '../models/responses/login_response.dart';

import '../models/requests/database_request.dart';
import '../models/responses/database_response.dart';

import '../models/requests/enterprise_config_request.dart';
import '../models/responses/enterprise_config_response.dart';

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

  Future<DataState<RecoveryCodeResponse>> requestRecoveryCode({
    required RecoveryCodeRequest request,
  });

  Future<DataState<ValidateRecoveryCodeResponse>> validateRecoveryCode({
    required ValidateCodeRequest request,
  });

  Future<DataState<ChangePasswordResponse>> changePassword({
    required ChangePasswordRequest request,
  });

  Future<DataState<DatabaseResponse>> database(
      {required DatabaseRequest request});
}
