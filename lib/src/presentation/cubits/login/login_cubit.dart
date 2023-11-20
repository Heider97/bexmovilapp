
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

//core
import '../../../core/functions.dart';
import '../../../core/abstracts/FormatAbstract.dart';

//domain

import '../../../domain/models/login.dart';
import '../../../domain/models/enterprise.dart';
import '../../../domain/models/requests/login_request.dart';
import '../../../domain/repositories/api_repository.dart';
import '../../../domain/repositories/database_repository.dart';
import 'package:location_repository/location_repository.dart';

//utils
import '../../../utils/resources/data_state.dart';
import '../../../utils/constants/strings.dart';

//service
import '../../../locator.dart';
import '../../../services/storage.dart';
import '../../../services/navigation.dart';
import '../base/base_cubit.dart';

part 'login_state.dart';

final LocalStorageService _storageService = locator<LocalStorageService>();
final NavigationService _navigationService = locator<NavigationService>();
final LocationRepository _locationRepository = locator<LocationRepository>();

class LoginCubit extends BaseCubit<LoginState, Login?> with FormatDate {
  final ApiRepository _apiRepository;
  final DatabaseRepository _databaseRepository;
  final _helperFunction = HelperFunctions();

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

      try {
        //TODO:: [Sebastian Monroy] All logic is handle by bloc or provider don´t write logic in ui
        final response = await Dio().get('https://worldtimeapi.org/api/ip');

        String? localHour;
        String? webHour;

        if (response.statusCode == 200) {
          localHour = DateFormat("HH:mm").format(DateTime.now());
          webHour = DateFormat("HH:mm")
              .format(DateTime.parse(response.data!['datetime']).toLocal());
        }

        if (localHour == webHour) {
          //TODO: [Felipe Bedoya] GET OTHERS VARIABLES LIKE DEVICE_ID,MODEL,DATE,LAT,LNG, VERSION
          var location = await _locationRepository.getCurrentLocation();
          var device = await _helperFunction.getDevice();

          final response = await _apiRepository.login(
            request: LoginRequest(
                usernameController.text,
                passwordController.text,
                device!['id'],
                device['model'],
                now(),
                location.latitude.toString(),
                location.longitude.toString()),
          );

          if (response is DataSuccess) {
            final login = response.data!.login;

            _storageService.setString('username', usernameController.text);
            _storageService.setString('password', passwordController.text);
            _storageService.setString('token', login?.token);
            _storageService.setObject('user', login?.user!.toMap());

            await _databaseRepository.init();

            //TODO: [Jairo Grande] SYNC LOGIC

            emit(LoginSuccess(
                // login: login,
                enterprise: _storageService.getObject('enterprise') != null
                    ? Enterprise.fromMap(
                        _storageService.getObject('enterprise')!)
                    : null));
          } else if (response is DataFailed) {
            emit(LoginFailed(
                error: response.error,
                enterprise: _storageService.getObject('enterprise') != null
                    ? Enterprise.fromMap(
                        _storageService.getObject('enterprise')!)
                    : null));
          }
        } else {
          emit(LoginFailed(
              error:
                  'Las horas no son iguales porfavor actualiza la hora de tu dispositivo a la hora correcta.',
              enterprise: _storageService.getObject('enterprise') != null
                  ? Enterprise.fromMap(_storageService.getObject('enterprise')!)
                  : null));
        }
      } catch (e) {
        emit(LoginFailed(
            error: e.toString(),
            enterprise: _storageService.getObject('enterprise') != null
                ? Enterprise.fromMap(_storageService.getObject('enterprise')!)
                : null));
      }
    });
  }

  void goToHome() {
    _navigationService.replaceTo(Routes.homeRoute);
  }

  void goToCompany() {
    _storageService.remove('company_name');
    _storageService.remove('enterprise');

    _navigationService.replaceTo(Routes.companyRoute);
  }
}
