import 'dart:io';
import 'package:bexmovil/src/domain/models/responses/sync_response.dart';
import 'package:bexmovil/src/domain/models/enterprise.dart';

import 'package:bexmovil/src/domain/models/responses/change_password_response.dart';
import 'package:bexmovil/src/domain/models/responses/recovery_code_response.dart';
import 'package:bexmovil/src/domain/models/responses/validate_recovery_code_response.dart';
import 'package:dio/dio.dart';

//models
import '../../../domain/models/login.dart';
import '../../../domain/models/enterprise_config.dart';

//interceptor
import 'interceptor_api_service.dart';

//response
import '../../../domain/models/responses/enterprise_response.dart';
import '../../../domain/models/responses/login_response.dart';

import '../../../domain/models/responses/enterprise_config_response.dart';

//services
import '../../../services/storage.dart';

class ApiService {
  late Dio dio;
  late LocalStorageService storageService;
  late bool testing;

  String? get url {
    var company = storageService.getString('company_name');
    if (company == null) return null;
    return 'https://$company.bexmovil.com/api';
  }

  ApiService(
      {required this.dio,
      required this.storageService,
      required this.testing}) {
    url != null
        ? dio.options.baseUrl = url!
        : dio.options.baseUrl = 'https://pandapan.bexmovil.com/api';
    !testing ? dio.interceptors.add(Logging(dio: dio)) : null;
  }

  //ENTERPRISES.
  Future<Response<EnterpriseResponse>> getEnterprise(String company) async {
    const extra = <String, dynamic>{};
    final headers = <String, dynamic>{};
    final data = <String, dynamic>{r'name': company};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final result = await dio.fetch<Map<String, dynamic>>(
        _setStreamType<Response<EnterpriseResponse>>(Options(
      method: 'GET',
      headers: headers,
      extra: extra,
    )
            .compose(
              dio.options,
              '/auth/enterprise',
              queryParameters: queryParameters,
              data: data,
            )
            .copyWith(baseUrl: url ?? dio.options.baseUrl)));
    final value = EnterpriseResponse.fromMap(result.data!);

    return Response(
        data: value,
        requestOptions: result.requestOptions,
        statusCode: result.statusCode,
        statusMessage: result.statusMessage,
        isRedirect: result.isRedirect,
        redirects: result.redirects,
        extra: result.extra,
        headers: result.headers);
  }

  Future<Response<EnterpriseConfigResponse>> getConfigEnterprise() async {
    const extra = <String, dynamic>{};
    final headers = <String, dynamic>{};
    final data = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final result = await dio.fetch<Map<String, dynamic>>(
        _setStreamType<Response<EnterpriseConfigResponse>>(Options(
      method: 'GET',
      headers: headers,
      extra: extra,
    )
            .compose(
              dio.options,
              '/auth/config',
              queryParameters: queryParameters,
              data: data,
            )
            .copyWith(baseUrl: url ?? dio.options.baseUrl)));
    final value = EnterpriseConfigResponse(
        enterpriseConfig: EnterpriseConfig.fromMap(result.data!));

    return Response(
        data: value,
        requestOptions: result.requestOptions,
        statusCode: result.statusCode,
        statusMessage: result.statusMessage,
        isRedirect: result.isRedirect,
        redirects: result.redirects,
        extra: result.extra,
        headers: result.headers);
  }

  Future<Response<LoginResponse>> login(
      {username,
      password,
      deviceId,
      model,
      date,
      version,
      latitude,
      longitude}) async {
    const extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final headers = <String, dynamic>{
      HttpHeaders.contentTypeHeader: 'application/json'
    };
    final data = <String, dynamic>{
      r'email': username,
      r'password': password,
      r'device_id': deviceId,
      r'phonetype': model,
      r'date': date,
      r'version': version,
      r'latitude': latitude,
      r'longitude': longitude,
    };

    data.removeWhere((k, v) => v == null);

    final result = await dio.fetch<Map<String, dynamic>>(
        _setStreamType<Response<LoginResponse>>(Options(
      method: 'POST',
      headers: headers,
      extra: extra,
    )
            .compose(
              dio.options,
              '/auth/login',
              queryParameters: queryParameters,
              data: data,
            )
            .copyWith(baseUrl: url ?? dio.options.baseUrl)));

    final value = LoginResponse(
        status: result.data!['status'],
        message: result.data!['message'],
        login: Login.fromMap(result.data!));

    return Response(
        data: value,
        requestOptions: result.requestOptions,
        statusCode: result.statusCode,
        statusMessage: result.statusMessage,
        isRedirect: result.isRedirect,
        redirects: result.redirects,
        extra: result.extra,
        headers: result.headers);
  }

  Future<Response<SyncResponse>> syncfeatures()async{
    const extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);

    final data = <String, dynamic>{};

    final headers = <String, dynamic>{
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    final result = await dio.fetch<Map<String, dynamic>>(
      _setStreamType<Response<SyncResponse>>(Options(
        method: 'GET',
        headers: headers,
        extra: extra,
      )
            .compose(dio.options, 'sync/features',
              queryParameters: queryParameters, data: data)
              .copyWith(baseUrl: url ?? dio.options.baseUrl)));
    
    final value = SyncResponse.fromMap(result.data!);

    return Response(
      data: value,
      requestOptions: result.requestOptions,
      statusCode: result.statusCode,
      statusMessage: result.statusMessage,
      isRedirect: result.isRedirect,
      redirects: result.redirects,
      extra: result.extra,
      headers: result.headers,
    );
  }

  Future<Response<RecoveryCodeResponse>> requestRecoveryCode(
      {required String email}) async {

    const extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final headers = <String, dynamic>{
      HttpHeaders.contentTypeHeader: 'application/json'
    };
    final data = <String, dynamic>{r'email': email};

    data.removeWhere((k, v) => v == null);

    final result = await dio.fetch<Map<String, dynamic>>(
        _setStreamType<Response<RecoveryCodeResponse>>(Options(
      method: 'POST',
      headers: headers,
      extra: extra,
    )
            .compose(
              dio.options,
              '/password/email',
              queryParameters: queryParameters,
              data: data,
            )
            .copyWith(baseUrl: url ?? dio.options.baseUrl)));

    final value = RecoveryCodeResponse(
      status: result.data!['status'],
      message: result.data!['message'],
    );

    return Response(
        data: value,
        requestOptions: result.requestOptions,
        statusCode: result.statusCode,
        statusMessage: result.statusMessage,
        isRedirect: result.isRedirect,
        redirects: result.redirects,
        extra: result.extra,
        headers: result.headers);
  }

  Future<Response<ValidateRecoveryCodeResponse>> validateRecoveryCode(
      {required String code}) async {
    const extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final headers = <String, dynamic>{
      HttpHeaders.contentTypeHeader: 'application/json'
    };
    final data = <String, dynamic>{r'code': code};

    data.removeWhere((k, v) => v == null);

    final result = await dio.fetch<Map<String, dynamic>>(
        _setStreamType<Response<ValidateRecoveryCodeResponse>>(Options(
      method: 'POST',
      headers: headers,
      extra: extra,
    )
            .compose(
              dio.options,
              '/password/code/check',
              queryParameters: queryParameters,
              data: data,
            )
            .copyWith(baseUrl: url ?? dio.options.baseUrl)));

    final value = ValidateRecoveryCodeResponse(
        status: result.data!['status'],
        message: result.data!['message'],
        code: result.data!['code']);

    return Response(
        data: value,
        requestOptions: result.requestOptions,
        statusCode: result.statusCode,
        statusMessage: result.statusMessage,
        isRedirect: result.isRedirect,
        redirects: result.redirects,
        extra: result.extra,
        headers: result.headers);
  }

  Future<Response<ChangePasswordResponse>> changePassword(
      {required String code, required String password}) async {
    const extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final headers = <String, dynamic>{
      HttpHeaders.contentTypeHeader: 'application/json'
    };
    final data = <String, dynamic>{r'code': code, r'password': password};

    data.removeWhere((k, v) => v == null);

    final result = await dio.fetch<Map<String, dynamic>>(
        _setStreamType<Response<ChangePasswordResponse>>(Options(
      method: 'POST',
      headers: headers,
      extra: extra,
    )
            .compose(
              dio.options,
              '/password/reset',
              queryParameters: queryParameters,
              data: data,
            )
            .copyWith(baseUrl: url ?? dio.options.baseUrl)));

    final value = ChangePasswordResponse(
      status: result.data!['status'],
      message: result.data!['message'],
    );

    return Response(
        data: value,
        requestOptions: result.requestOptions,
        statusCode: result.statusCode,
        statusMessage: result.statusMessage,
        isRedirect: result.isRedirect,
        redirects: result.redirects,
        extra: result.extra,
        headers: result.headers);
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
