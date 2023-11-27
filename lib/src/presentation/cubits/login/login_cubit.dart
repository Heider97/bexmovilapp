import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:location_repository/location_repository.dart';
import 'package:yaml/yaml.dart';

//core
import '../../../core/functions.dart';
import '../../../core/abstracts/FormatAbstract.dart';

//domain
import '../../../domain/models/isolate.dart';
import '../../../domain/models/login.dart';
import '../../../domain/models/enterprise.dart';
import '../../../domain/models/requests/login_request.dart';
import '../../../domain/repositories/api_repository.dart';
import '../../../domain/repositories/database_repository.dart';

//utils
import '../../../utils/resources/data_state.dart';
import '../../../utils/constants/strings.dart';

//service
import '../../../services/storage.dart';
import '../../../services/navigation.dart';
import '../base/base_cubit.dart';

part 'login_state.dart';

class LoginCubit extends BaseCubit<LoginState, Login?> with FormatDate {
  final ApiRepository _apiRepository;
  final DatabaseRepository _databaseRepository;
  final LocalStorageService? _storageService;
  final NavigationService? _navigationService;
  final LocationRepository? _locationRepository;
  final _helperFunction = HelperFunctions();

  LoginCubit(this._apiRepository, this._databaseRepository,
      this._storageService, this._navigationService, this._locationRepository)
      : super(
            LoginInitial(
                enterprise: _storageService!.getObject('enterprise') != null
                    ? Enterprise.fromMap(
                        _storageService.getObject('enterprise')!)
                    : null),
            null);

  Future<void> heavyTask(IsolateModel model) async {
    for (var i = 0; i < model.iteration; i++) {
      await model.functions[i]();
    }
  }

  Future<void> getConfigs() async {
    final response = await _apiRepository.configs();

    if (response is DataSuccess) {
      await _databaseRepository.init(null, []);
      await _databaseRepository.insertConfigs(response.data!.configs);
    } else {
      emit(LoginFailed(
          error: 'configs-${response.data!.message}',
          enterprise: _storageService!.getObject('enterprise') != null
              ? Enterprise.fromMap(_storageService!.getObject('enterprise')!)
              : null));
    }
  }

  Future<void> getFeatures() async {
    final response = await _apiRepository.features();

    if (response is DataSuccess) {
      await _databaseRepository.insertFeatures(response.data!.features);
    } else {
      emit(LoginFailed(
          error: 'features-${response.data!.message}',
          enterprise: _storageService!.getObject('enterprise') != null
              ? Enterprise.fromMap(_storageService!.getObject('enterprise')!)
              : null));
    }
  }

  Future<void> differenceHours(username, password) async {
    if (isBusy) return;

    try {
      emit(LoginLoading(
          enterprise: _storageService!.getObject('enterprise') != null
              ? Enterprise.fromMap(_storageService!.getObject('enterprise')!)
              : null));

      final response = await Dio().get('https://worldtimeapi.org/api/ip');

      String? localHour;
      String? webHour;

      if (response.statusCode == 200) {
        localHour = DateFormat("HH:mm").format(DateTime.now());
        webHour = DateFormat("HH:mm")
            .format(DateTime.parse(response.data!['datetime']).toLocal());
      }

      if (localHour == webHour) {
        var location = await _locationRepository?.getCurrentLocation();
        var device = await _helperFunction.getDevice();
        var yaml = loadYaml(await rootBundle.loadString('pubspec.yaml'));
        var version = yaml['version'];

        var loginRequest = LoginRequest(
            username,
            password,
            device!['id'],
            device['model'],
            version,
            now(),
            location?.latitude.toString(),
            location?.longitude.toString());

        await onPressedLogin(loginRequest);
      } else {
        emit(LoginFailed(
            error:
                'Las horas no son iguales porfavor actualiza la hora de tu dispositivo a la hora correcta.',
            enterprise: _storageService!.getObject('enterprise') != null
                ? Enterprise.fromMap(_storageService!.getObject('enterprise')!)
                : null));
      }
    } catch (e) {
      emit(LoginFailed(
          error: e.toString(),
          enterprise: _storageService!.getObject('enterprise') != null
              ? Enterprise.fromMap(_storageService!.getObject('enterprise')!)
              : null));
    }
  }

  Future<void> onPressedLogin(LoginRequest loginRequest,
      {bool testing = false}) async {
    if (isBusy) return;

    await run(() async {
      try {
        emit(LoginLoading(
            enterprise: _storageService!.getObject('enterprise') != null
                ? Enterprise.fromMap(_storageService!.getObject('enterprise')!)
                : null));

        final response = await _apiRepository.login(
          request: loginRequest,
        );

        if (response is DataSuccess) {
          final login = response.data!.login;

          if (!testing) {
            _storageService!.setString('username', loginRequest.username);
            _storageService!.setString('password', loginRequest.password);
            _storageService!.setString('token', login?.token);
            _storageService!.setObject('user', login?.user!.toMap());

            var functions = [getConfigs, getFeatures];

            var isolateModel = IsolateModel(functions, 2);
            await heavyTask(isolateModel);
          }

          //TODO: [Jairo Grande] SYNC LOGIC
          emit(LoginSuccess(
              login: login,
              enterprise: _storageService!.getObject('enterprise') != null
                  ? Enterprise.fromMap(
                      _storageService!.getObject('enterprise')!)
                  : null));
        } else if (response is DataFailed) {
          emit(LoginFailed(
              error: response.error,
              enterprise: _storageService!.getObject('enterprise') != null
                  ? Enterprise.fromMap(
                      _storageService!.getObject('enterprise')!)
                  : null));
        }
      } catch (e) {
        emit(LoginFailed(
            error: e.toString(),
            enterprise: _storageService!.getObject('enterprise') != null
                ? Enterprise.fromMap(_storageService!.getObject('enterprise')!)
                : null));
      }
    });
  }

  void goToSync() {
    _navigationService!.replaceTo(Routes.syncRoute);
  }

  void goToCompany() {
    _storageService!.remove('company_name');
    _storageService!.remove('enterprise');

    _navigationService!.replaceTo(Routes.selectEnterpriseRoute);
  }

  void goToForget() {
    _navigationService!.replaceTo(Routes.selectEnterpriseRoute);
  }
}
