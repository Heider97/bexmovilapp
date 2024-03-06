import 'dart:io';
import 'package:dio/dio.dart';

//interceptor
import 'interceptor_api_service.dart';

//requests
import '../../../domain/models/requests/google_maps_request.dart';
//responses
import '../../../domain/models/responses/enterprise_response.dart';
import '../../../domain/models/responses/login_response.dart';
import '../../../domain/models/responses/change_password_response.dart';
import '../../../domain/models/responses/recovery_code_response.dart';
import '../../../domain/models/responses/kpi_response.dart';
import '../../../domain/models/responses/sync_priorities_response.dart';
import '../../../domain/models/responses/validate_recovery_code_response.dart';
import '../../../domain/models/responses/dynamic_response.dart';
import '../../../domain/models/responses/google_response.dart';
import '../../../domain/models/responses/config_response.dart';
import '../../../domain/models/responses/sync_response.dart';
import '../../../domain/models/responses/functionality_response.dart';
import '../../../domain/models/responses/graphic_response.dart';
import '../../../domain/models/responses/filter_response.dart';
import '../../../domain/models/responses/nearby_places_response.dart';

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
    dio.options.validateStatus = (_) => true;
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

  Future<Response<ConfigResponse>> configs() async {
    const extra = <String, dynamic>{};
    final headers = <String, dynamic>{};
    final data = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final result = await dio.fetch<Map<String, dynamic>>(
        _setStreamType<Response<ConfigResponse>>(Options(
      method: 'GET',
      headers: headers,
      extra: extra,
    )
            .compose(
              dio.options,
              '/auth/enterprise/configs',
              queryParameters: queryParameters,
              data: data,
            )
            .copyWith(baseUrl: url ?? dio.options.baseUrl)));
    final value = ConfigResponse.fromMap(result.data!);

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

  Future<Response<LoginResponse>> login({loginRequest}) async {
    const extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final headers = <String, dynamic>{
      HttpHeaders.contentTypeHeader: 'application/json'
    };
    final data = <String, dynamic>{
      r'email': loginRequest.username,
      r'password': loginRequest.password,
      r'udid': loginRequest.deviceId,
      r'phonetype': loginRequest.model,
      r'date': loginRequest.date,
      r'version': loginRequest.version,
      r'latitude': loginRequest.latitude,
      r'longitude': loginRequest.longitude,
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

    final value = LoginResponse.fromMap(result.data!);

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

  Future<Response<GoogleResponse>> googleCount() async {
    const extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final headers = <String, dynamic>{
      HttpHeaders.contentTypeHeader: 'application/json'
    };

    final data = <String, dynamic>{};

    data.removeWhere((k, v) => v == null);

    final result = await dio.fetch<Map<String, dynamic>>(
        _setStreamType<Response<GoogleResponse>>(
            Options(method: 'POST', headers: headers, extra: extra)
                .compose(
                  dio.options,
                  '/v1/accounts:signUp',
                  queryParameters: queryParameters,
                  data: data,
                )
                .copyWith(baseUrl: 'https://identitytoolkit.googleapis.com')));

    final value = GoogleResponse.fromMap(result.data!);

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

  Future<Response<NearbyPlacesResponse>> places(
      {required GoogleMapsRequest request}) async {
    const extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      'location': '${request.latitude},${request.longitude}',
      'radius': request.radius,
      'key': request.apiKey
    };
    queryParameters.removeWhere((k, v) => v == null);
    final headers = <String, dynamic>{
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptCharsetHeader: ''
    };
    final data = <String, dynamic>{};
    data.removeWhere((k, v) => v == null);
    final result = await dio.fetch<Map<String, dynamic>>(
        _setStreamType<Response<NearbyPlacesResponse>>(
            Options(method: 'POST', headers: headers, extra: extra)
                .compose(
                  dio.options,
                  '/maps/api/place/nearbysearch/json',
                  queryParameters: queryParameters,
                  data: data,
                )
                .copyWith(baseUrl: 'https://maps.googleapis.com')));

    final value = NearbyPlacesResponse.fromJson(result.data!);

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

  Future<Response<SyncResponse>> features() async {
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
            .compose(dio.options, '/sync/features',
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

  Future<Response<SyncPrioritiesResponse>> priorities(
      {required String date, required String version}) async {
    const extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);

    final data = <String, dynamic>{r'date': date, r'version': version};

    final headers = <String, dynamic>{
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    final result = await dio.fetch<Map<String, dynamic>>(
        _setStreamType<Response<SyncPrioritiesResponse>>(Options(
      method: 'GET',
      headers: headers,
      extra: extra,
    )
            .compose(dio.options, '/sync/priorities',
                queryParameters: queryParameters, data: data)
            .copyWith(baseUrl: url ?? dio.options.baseUrl)));

    final value = SyncPrioritiesResponse.fromJson(result.data!);

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

  Future<Response<DynamicResponse>> syncDynamic(
      {required String table, required String content}) async {
    const extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);

    final data = <String, dynamic>{r'table': table, 'content': content};

    final headers = <String, dynamic>{
      HttpHeaders.contentTypeHeader: content,
    };

    final result = await dio.fetch<Map<String, dynamic>>(
        _setStreamType<Response<SyncPrioritiesResponse>>(Options(
      method: 'GET',
      headers: headers,
      extra: extra,
    )
            .compose(dio.options, '/sync/dynamic',
                queryParameters: queryParameters, data: data)
            .copyWith(baseUrl: url ?? dio.options.baseUrl)));

    final value = DynamicResponse.fromMap(result.data!, table);

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

  Future<Response<KpiResponse>> kpis({required String codvendedor}) async {
    const extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);

    final data = <String, dynamic>{r'codvendedor': codvendedor};

    final headers = <String, dynamic>{};

    final result = await dio.fetch<Map<String, dynamic>>(
        _setStreamType<Response<KpiResponse>>(Options(
      method: 'GET',
      headers: headers,
      extra: extra,
    )
            .compose(dio.options, '/sync/kpis',
                queryParameters: queryParameters, data: data)
            .copyWith(baseUrl: url ?? dio.options.baseUrl)));

    final value = KpiResponse.fromJson(result.data!);

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

  Future<Response<FunctionalityResponse>> functionalities(
      {required String codvendedor}) async {
    const extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);

    final data = <String, dynamic>{r'codvendedor': codvendedor};

    final headers = <String, dynamic>{};

    final result = await dio.fetch<Map<String, dynamic>>(
        _setStreamType<Response<FunctionalityResponse>>(Options(
      method: 'GET',
      headers: headers,
      extra: extra,
    )
            .compose(dio.options, '/sync/functionalities',
                queryParameters: queryParameters, data: data)
            .copyWith(baseUrl: url ?? dio.options.baseUrl)));

    final value = FunctionalityResponse.fromJson(result.data!);

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

  Future<Response<GraphicResponse>> graphics(
      {required String codvendedor}) async {
    const extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);

    final data = <String, dynamic>{r'codvendedor': codvendedor};

    final headers = <String, dynamic>{};

    final result = await dio.fetch<Map<String, dynamic>>(
        _setStreamType<Response<GraphicResponse>>(Options(
      method: 'GET',
      headers: headers,
      extra: extra,
    )
            .compose(dio.options, '/graphics/index',
                queryParameters: queryParameters, data: data)
            .copyWith(baseUrl: url ?? dio.options.baseUrl)));

    final value = GraphicResponse.fromJson(result.data!);

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

  Future<Response<FilterResponse>> filters(
      {required String codvendedor}) async {
    const extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);

    final data = <String, dynamic>{r'codvendedor': codvendedor};

    final headers = <String, dynamic>{};

    final result = await dio.fetch<Map<String, dynamic>>(
        _setStreamType<Response<FilterResponse>>(Options(
      method: 'GET',
      headers: headers,
      extra: extra,
    )
            .compose(dio.options, '/filters/index',
                queryParameters: queryParameters, data: data)
            .copyWith(baseUrl: url ?? dio.options.baseUrl)));

    final value = FilterResponse.fromJson(result.data!);

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
