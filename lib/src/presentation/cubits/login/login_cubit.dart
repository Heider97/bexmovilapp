import 'package:bexmovil/src/domain/models/requests/kpi_request.dart';
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
  final ApiRepository apiRepository;
  final DatabaseRepository databaseRepository;
  final LocalStorageService? storageService;
  final NavigationService? navigationService;
  final LocationRepository? locationRepository;
  final _helperFunction = HelperFunctions();

  LoginCubit(this.apiRepository, this.databaseRepository, this.storageService,
      this.navigationService, this.locationRepository)
      : super(
            LoginInitial(
                enterprise: storageService!.getObject('enterprise') != null
                    ? Enterprise.fromMap(
                        storageService.getObject('enterprise')!)
                    : null),
            null);

  Future<void> heavyTask(IsolateModel model) async {
    for (var i = 0; i < model.iteration; i++) {
      await model.functions[i]();
    }
  }

  Future<void> getConfigs() async {
    final response = await apiRepository.configs();

    if (response is DataSuccess) {
      await databaseRepository.init();
      await databaseRepository.insertConfigs(response.data!.configs);
    } else {
      emit(LoginFailed(
          error: 'configs-${response.data!.message}',
          enterprise: storageService!.getObject('enterprise') != null
              ? Enterprise.fromMap(storageService!.getObject('enterprise')!)
              : null));
    }
  }

  Future<void> getFeatures() async {
    final response = await apiRepository.features();

    if (response is DataSuccess) {
      await databaseRepository.insertFeatures(response.data!.features);
    } else {
      emit(LoginFailed(
          error: 'features-${response.data!.message}',
          enterprise: storageService!.getObject('enterprise') != null
              ? Enterprise.fromMap(storageService!.getObject('enterprise')!)
              : null));
    }
  }

  Future<void> getKpis() async {
    final response = await apiRepository.kpis(
        request:
            KpiRequest(codvendedor: storageService!.getString('username')!));

    if (response is DataSuccess) {
      await databaseRepository.insertKpis(response.data!.kpis);
    } else {
      emit(LoginFailed(
          error: 'kpis-${response.data!.message}',
          enterprise: storageService!.getObject('enterprise') != null
              ? Enterprise.fromMap(storageService!.getObject('enterprise')!)
              : null));
    }
  }

  Future<void> differenceHours(username, password) async {
    if (isBusy) return;

    try {
      emit(LoginLoading(
          enterprise: storageService!.getObject('enterprise') != null
              ? Enterprise.fromMap(storageService!.getObject('enterprise')!)
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
        var location = await locationRepository?.getCurrentLocation();
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
            enterprise: storageService!.getObject('enterprise') != null
                ? Enterprise.fromMap(storageService!.getObject('enterprise')!)
                : null));
      }
    } catch (e) {
      emit(LoginFailed(
          error: e.toString(),
          enterprise: storageService!.getObject('enterprise') != null
              ? Enterprise.fromMap(storageService!.getObject('enterprise')!)
              : null));
    }
  }

  Future<void> onPressedLogin(LoginRequest loginRequest,
      {bool testing = false}) async {
    if (isBusy) return;

    await run(() async {
      try {
        emit(LoginLoading(
            enterprise: storageService!.getObject('enterprise') != null
                ? Enterprise.fromMap(storageService!.getObject('enterprise')!)
                : null));

        final response = await apiRepository.login(
          request: loginRequest,
        );

        if (response is DataSuccess) {
          final login = response.data!.login;

          if (!testing) {
            storageService!.setString('username', loginRequest.username);
            storageService!.setString('password', loginRequest.password);
            storageService!.setString('token', login?.token);
            storageService!.setObject('user', login?.user!.toMap());

            var functions = [getConfigs, getFeatures, getKpis];

            var isolateModel = IsolateModel(functions, null, 3);
            await heavyTask(isolateModel);
          }

          emit(LoginSuccess(
              login: login,
              enterprise: storageService!.getObject('enterprise') != null
                  ? Enterprise.fromMap(storageService!.getObject('enterprise')!)
                  : null));
        } else if (response is DataFailed) {
          emit(LoginFailed(
              error: response.error,
              enterprise: storageService!.getObject('enterprise') != null
                  ? Enterprise.fromMap(storageService!.getObject('enterprise')!)
                  : null));
        }
      } catch (e) {
        emit(LoginFailed(
            error: e.toString(),
            enterprise: storageService!.getObject('enterprise') != null
                ? Enterprise.fromMap(storageService!.getObject('enterprise')!)
                : null));
      }
    });
  }

  void goToSync() {
    navigationService!.replaceTo(Routes.syncRoute);
  }

  void goToCompany() {
    storageService!.remove('company_name');
    storageService!.remove('enterprise');

    navigationService!.replaceTo(Routes.selectEnterpriseRoute);
  }

  void goToForget() {
    navigationService!.replaceTo(Routes.selectEnterpriseRoute);
  }
}
