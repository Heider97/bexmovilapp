import 'dart:io' show HttpStatus;

import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../../../utils/resources/data_state.dart';
import 'dio_exceptions.dart';

abstract class BaseApiRepository {
  @protected
  Future<DataState<T>> getStateOf<T>({
    required Future<Response<T>> Function() request,
  }) async {
    try {
      final httpResponse = await request();

      print('******ressponse******');
      print(httpResponse.statusCode);
      print(httpResponse.data);

      if (httpResponse.statusCode == HttpStatus.ok || httpResponse.statusCode == HttpStatus.created) {
        return DataSuccess(httpResponse.data as T);
      } else {
        throw DioException(
          response: httpResponse,
          requestOptions: httpResponse.requestOptions
        );
      }
    } on DioException catch (error) {
      print(error.toString());
      print(error.error);
      print(error.response);
      print(error.type);
      print(error.message);
      final errorMessage = DioExceptions.fromDioError(error).toString();
      return DataFailed(errorMessage);
    }
  }
}