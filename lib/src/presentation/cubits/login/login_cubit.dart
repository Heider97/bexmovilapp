import 'dart:async';
import 'dart:convert';
import 'package:BexMovil/src/utils/constants/extensions/string_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:location_repository/location_repository.dart';
import 'package:path_provider/path_provider.dart';

//domain
import '../../../domain/models/login.dart';
import '../../../domain/models/enterprise.dart';
import '../../../domain/models/category.dart';
import '../../../domain/models/product.dart';
import '../../../domain/models/responses/enterprise_config_response.dart';
import '../../../domain/models/requests/login_request.dart';
import '../../../domain/models/requests/enterprise_config_request.dart';
import '../../../domain/repositories/api_repository.dart';
import '../../../domain/repositories/database_repository.dart';

//utils
import '../../../utils/resources/data_state.dart';
import '../base/base_cubit.dart';
import '../location/location_bloc.dart';

//service
import '../../../locator.dart';
import '../../../services/storage.dart';

part 'login_state.dart';

final LocalStorageService _storageService = locator<LocalStorageService>();

class LoginCubit extends BaseCubit<LoginState, Login?> {
  final ApiRepository _apiRepository;
  final DatabaseRepository _databaseRepository;

  LoginCubit(this._apiRepository, this._databaseRepository)
      : super(LoginSuccess(enterprise: _storageService.getObject('enterprise') != null
                    ? Enterprise.fromMap(
                        _storageService.getObject('enterprise')!)
                    : null),
            null);

  Future<void> onPressedLogin(TextEditingController usernameController,
      TextEditingController passwordController) async {
    if (isBusy) return;

    await run(() async {
      emit(LoginLoading(
          enterprise: _storageService.getObject('enterprise') != null
              ? Enterprise.fromMap(_storageService.getObject('enterprise')!)
              : null));

     await _databaseRepository.init();

      final String response = await rootBundle.loadString('assets/data/products.json');
      final data = await json.decode(response);

      var len = data.length;
      var size = 25;
      var chunks = [];

      for(var i = 0; i< len; i+= size) {
        var end = (i+size<len)?i+size:len;
        chunks.add(data.sublist(i,end));
      }

      var images = [
        'pizza',
        'hamburger',
        'hot-dog',
        'steak'
      ];

      for(var j = 0; j < chunks.length; j++){
        var category = Category(name: ' ${images[j].capitalize} Category', image: 'assets/images/${images[j]}.png');

        var id = await _databaseRepository.insertCategory(category);

        final products = chunks[j].map<Product>((product) {
          product['category_id'] = id;
          return Product.fromMap(product);
        }).toList();

        await _databaseRepository.insertProducts(products);

      }

      _storageService.setString('token', 'token');

      emit(const LoginSuccess());

      // final results = await Future.wait([
      //   _apiRepository.getConfigEnterprise(request: EnterpriseConfigRequest()),
      // ]);
      //
      // if (results.isNotEmpty) {
      //   if (results[0] is DataSuccess) {
      //     var data = results[0].data as EnterpriseConfigResponse;
      //     _storageService.setObject('config', data.enterpriseConfig.toMap());
      //   }
      // }
      //
      // final response = await _apiRepository.login(
      //   request: LoginRequest(usernameController.text, passwordController.text),
      // );
      //
      // if (response is DataSuccess) {
      //   final login = response.data!.login;
      //
      //   _storageService.setString('username', usernameController.text);
      //   _storageService.setString('password', passwordController.text);
      //   _storageService.setString('token', response.data!.login.token);
      //   _storageService.setObject('user', response.data!.login.user!.toMap());
      //
      //   emit(LoginSuccess(
      //       login: login,
      //       enterprise: _storageService.getObject('enterprise') != null
      //           ? Enterprise.fromMap(_storageService.getObject('enterprise')!)
      //           : null));
      // } else if (response is DataFailed) {
      //   emit(LoginFailed(
      //       error: response.error,
      //       enterprise: _storageService.getObject('enterprise') != null
      //           ? Enterprise.fromMap(_storageService.getObject('enterprise')!)
      //           : null));
      // }
    });
  }
}
