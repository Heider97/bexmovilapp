import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

//core
import '../../../core/functions.dart';

//services
import '../../../locator.dart';
import '../../../services/storage.dart';

final LocalStorageService _storageService = locator<LocalStorageService>();
const String appToken = 'token';

final helperFunction = HelperFunctions();

class Logging extends Interceptor {
  Logging({
    required this.dio,
  });

  final Dio dio;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (kDebugMode) {
      print('REQUEST[${options.method}] => PATH: ${options.path}');
    }
    try {
      var token = _storageService.getString(appToken) ?? '';
      options.headers['Authorization'] = 'Bearer $token';
      options.headers[HttpHeaders.contentTypeHeader] = 'application/json';
      options.headers[HttpHeaders.acceptHeader] = 'application/json';
    } catch (e) {
      if (kDebugMode) {
        print('***************');
        print(e);
      }
    }
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      print(
        'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}',
      );
    }
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (_shouldRetryOnHttpException(err)) {
      try {
        handler.resolve(await DioHttpRequestRetrier(dio: dio)
            .requestRetry(err.requestOptions)
            // ignore: body_might_complete_normally_catch_error
            .catchError((e) {
          handler.next(err);
        }));
      } catch (e) {
        handler.next(err);
      }
    } else {
      handler.next(err);
    }
  }

  bool _shouldRetryOnHttpException(DioException err) {
    //TODO:: [Sebastian Monroy] Always try to verify that contains variables to do correct validations
    // if (err.type == DioExceptionType.badResponse &&
    //     !err.requestOptions.uri.toString().contains('auth') &&
    //     err.message != null && err.message!.contains('401')) {
    //   print('esta entrando aqui por error');
    //   Future.value(helperFunction.login());
    // }
    return err.type == DioExceptionType.unknown &&
        ((err.error is HttpException &&
            err.message!.contains(
                'Connection closed before full header was received')));
  }
}

/// Retrier
class DioHttpRequestRetrier {
  DioHttpRequestRetrier({
    required this.dio,
  });

  final Dio dio;

  Future<Response> requestRetry(RequestOptions requestOptions) async {
    return dio.request(
      requestOptions.path,
      cancelToken: requestOptions.cancelToken,
      data: requestOptions.data,
      onReceiveProgress: requestOptions.onReceiveProgress,
      onSendProgress: requestOptions.onSendProgress,
      queryParameters: requestOptions.queryParameters,
      options: Options(
        contentType: requestOptions.contentType,
        headers: requestOptions.headers,
        sendTimeout: requestOptions.sendTimeout,
        receiveTimeout: requestOptions.receiveTimeout,
        extra: requestOptions.extra,
        followRedirects: requestOptions.followRedirects,
        listFormat: requestOptions.listFormat,
        maxRedirects: requestOptions.maxRedirects,
        method: requestOptions.method,
        receiveDataWhenStatusError: requestOptions.receiveDataWhenStatusError,
        requestEncoder: requestOptions.requestEncoder,
        responseDecoder: requestOptions.responseDecoder,
        responseType: requestOptions.responseType,
        validateStatus: requestOptions.validateStatus,
      ),
    );
  }
}
