import 'dart:convert';
import 'package:bexmovil/src/domain/models/requests/login_request.dart';
import 'package:bexmovil/src/domain/models/responses/login_response.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../utils/errors.dart';

class TestApiService {
  TestApiService({
    http.Client? httpClient,
    this.baseUrl = 'https://pandapan.bexmovil.com/v1',
  }) : _httpClient = httpClient ?? http.Client();

  final String baseUrl;
  final Client _httpClient;

  Future<LoginResponse> login(LoginRequest? data) async {
    final response = await _httpClient
        .post(Uri.parse('$baseUrl/auth/login'), body: data?.toMap());
    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        return LoginResponse.fromMap(json.decode(response.body)[0]);
      } else {
        throw ErrorEmptyResponse();
      }
    } else {
      throw ErrorLogin();
    }
  }
}