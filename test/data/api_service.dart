import 'dart:convert';
import 'package:bexmovil/src/domain/models/requests/login_request.dart';
import 'package:bexmovil/src/domain/models/responses/login_response.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../utils/errors.dart';

class TestApiService {
  TestApiService({
    http.Client? httpClient,
    this.baseUrl = 'https://pandapan.bexmovil.com/api',
  }) : _httpClient = httpClient ?? http.Client();

  final String baseUrl;
  final Client _httpClient;

  Future<LoginResponse> login(LoginRequest? data) async {

    print('*************');
    debugPrint(data?.toMap().toString());
    debugPrint(Uri.parse('$baseUrl/auth/login').toString());

    final response = await _httpClient
        .post(Uri.parse('$baseUrl/auth/login'), body: data?.toMap());

    debugPrint(response.statusCode.toString());

    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {

        debugPrint(response.body);
        return LoginResponse.fromMap(json.decode(response.body));
      } else {
        throw ErrorEmptyResponse();
      }
    } else {
      throw ErrorLogin();
    }
  }
}