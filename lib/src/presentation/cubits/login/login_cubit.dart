import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:yaml/yaml.dart';

//blocs
import '../../blocs/gps/gps_bloc.dart';

//core
import '../../../core/functions.dart';

//domain
import '../../../domain/abstracts/format_abstract.dart';
import '../../../domain/models/isolate.dart';
import '../../../domain/models/login.dart';
import '../../../domain/models/enterprise.dart';

import '../../../domain/repositories/api_repository.dart';
import '../../../domain/repositories/database_repository.dart';
import '../../../domain/models/requests/login_request.dart';

//utils
import '../../../utils/resources/data_state.dart';
import '../../../utils/constants/strings.dart';

//service
import '../../../services/storage.dart';
import '../../../services/navigation.dart';
import '../base/base_cubit.dart';

part 'login_state.dart';

class LoginCubit extends BaseCubit<LoginState> with FormatDate {
  final ApiRepository apiRepository;
  final DatabaseRepository databaseRepository;
  final LocalStorageService? storageService;
  final NavigationService? navigationService;
  final GpsBloc? gpsBloc;
  final _helperFunction = HelperFunctions();

  LoginCubit(this.apiRepository, this.databaseRepository, this.storageService,
      this.navigationService, this.gpsBloc)
      : super(LoginInitial(
            enterprise: storageService!.getObject('enterprise') != null
                ? Enterprise.fromMap(storageService.getObject('enterprise')!)
                : null));

  Future<void> heavyTask(IsolateModel model) async {
    for (var i = 0; i < model.iteration; i++) {
      await model.functions[i]();
    }
  }

  Future<void> getModules() async {
    // final response = await apiRepository.modules(
    //     request:
    //         ModuleRequest(codvendedor: storageService!.getString('username')!));
    //
    // if (response is DataSuccess) {
    //   await databaseRepository.init();
    //   if(response.data != null && response.data!.modules != null) {
    //     var modules = response.data!.modules;
    //     await databaseRepository.insertModules(modules!);
    //     for(var module in modules) {
    //      if(module.components != null) {
    //        await databaseRepository.insertComponents(module.components!);
    //        for(var component in module.components!){
    //          await databaseRepository.insertQueries(component.queries!);
    //        }
    //      }
    //     }
    //   }
    // } else {
    //   emit(LoginFailed(
    //       error: 'modules-${response.data!.message}',
    //       enterprise: storageService!.getObject('enterprise') != null
    //           ? Enterprise.fromMap(storageService!.getObject('enterprise')!)
    //           : null));
    // }
  }

  Future<void> getConfigs() async {
    final response = await apiRepository.configs();

    if (response is DataSuccess) {
      await databaseRepository.insertConfigs(response.data!.configs);
    } else {
      emit(LoginFailed(
          error: 'configs-${response.data!.message}',
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
        var location = await gpsBloc?.getCurrentLocation();
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

            var functions = [
              getModules,
              getConfigs,
            ];

            var isolateModel = IsolateModel(functions, null, 6);
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
    navigationService!.replaceTo(AppRoutes.sync);
  }

  void goToCompany() {
    storageService!.remove('company_name');
    storageService!.remove('enterprise');

    navigationService!.replaceTo(AppRoutes.selectEnterprise);
  }

  void goToForget() {
    navigationService!.replaceTo(AppRoutes.selectEnterprise);
  }
}
