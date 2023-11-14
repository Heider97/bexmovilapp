import 'dart:async';
import '../base/base_cubit.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

//domain
import '../../../domain/models/login.dart';
import '../../../domain/models/enterprise.dart';
import '../../../domain/models/category.dart';
import '../../../domain/models/requests/dummy_request.dart';
import '../../../domain/models/requests/login_request.dart';
import '../../../domain/repositories/api_repository.dart';
import '../../../domain/repositories/database_repository.dart';

//utils
import '../../../utils/resources/data_state.dart';
import '../../../utils/constants/strings.dart';

//service
import '../../../locator.dart';
import '../../../services/storage.dart';
import '../../../services/navigation.dart';

part 'login_state.dart';

final LocalStorageService _storageService = locator<LocalStorageService>();
final NavigationService _navigationService = locator<NavigationService>();

class LoginCubit extends BaseCubit<LoginState, Login?> {
  final ApiRepository _apiRepository;
  final DatabaseRepository _databaseRepository;

  LoginCubit(this._apiRepository, this._databaseRepository)
      : super(
            LoginSuccess(
                enterprise: _storageService.getObject('enterprise') != null
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

      _storageService.setString('token', 'token');

      //login(); //funcion del retry loguin

      final response = await _apiRepository.login(
        request: LoginRequest(usernameController.text, passwordController.text),
      );

      if (response is DataSuccess) {
        final login = response.data!.login;

        _storageService.setString('username', usernameController.text);
        _storageService.setString('password', passwordController.text);
        _storageService.setString('token', response.data!.login.token);
        // _storageService.setObject('user', response.data!.login.user!.toMap());

        final responseProducts = await _apiRepository.products(
          request: DummyRequest(),
        );

        if (responseProducts is DataSuccess) {
          final products = responseProducts.data!.products;

          for (var product in products) {
            var category = Category(name: product.category!);
            var id = await _databaseRepository.insertCategory(category);
            product.categoryId = id;
          }

          await _databaseRepository.insertProducts(products);

          emit(LoginSuccess(
              login: login,
              enterprise: _storageService.getObject('enterprise') != null
                  ? Enterprise.fromMap(_storageService.getObject('enterprise')!)
                  : null));
        } else if (responseProducts is DataFailed) {
          emit(LoginFailed(
              error: responseProducts.error,
              enterprise: _storageService.getObject('enterprise') != null
                  ? Enterprise.fromMap(_storageService.getObject('enterprise')!)
                  : null));
        }
      } else if (response is DataFailed) {
        emit(LoginFailed(
            error: response.error,
            enterprise: _storageService.getObject('enterprise') != null
                ? Enterprise.fromMap(_storageService.getObject('enterprise')!)
                : null));
      }
    });
  }

  Future<void> selectCompanyName() async {
    _storageService.setString('company_name', null);
    _navigationService.replaceTo(Routes.companyRoute);
  }
}
