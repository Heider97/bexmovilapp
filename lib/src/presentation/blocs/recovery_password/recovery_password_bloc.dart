import 'package:bexmovil/src/domain/models/requests/change_password_request.dart';
import 'package:bexmovil/src/domain/models/requests/recovery_code_request.dart';
import 'package:bexmovil/src/domain/models/requests/validate_code_request.dart';
import 'package:bexmovil/src/domain/repositories/api_repository.dart';
import 'package:bexmovil/src/locator.dart';
import 'package:bexmovil/src/presentation/widgets/global/error_alert_dialog.dart';

import 'package:bexmovil/src/services/navigation.dart';
import 'package:bexmovil/src/utils/resources/data_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/constants/strings.dart';

part 'recovery_password_event.dart';
part 'recovery_password_state.dart';

final NavigationService _navigationService = locator<NavigationService>();

class RecoveryPasswordBloc
    extends Bloc<RecoveryPasswordEvent, RecoveryPasswordState> {
  final ApiRepository _apiRepository;

  RecoveryPasswordBloc(this._apiRepository) : super(RecoveryPasswordState()) {
    on<StartRecovery>(_startRecovery);
    on<RequestCode>(_requestCode);
    on<ValidateCode>(_validateCode);
    on<ClearErrors>(
      (event, emit) => emit(state.copyWith(error: null)),
    );
    on<ChangePassword>(_changePassword);
  }

  _startRecovery(StartRecovery event, Emitter emit) {
    emit(state.copyWith(type: event.type));
  }

  _requestCode(RequestCode event, Emitter emit) async {
    emit(state.copyWith(error: null));
    final dynamic response;
    if (state.type == 'SMS') {
      emit(state.copyWith(phone: event.recoveryMethod));
      response = await _apiRepository.requestRecoveryCode(
          request: RecoveryCodeRequest(event.recoveryMethod));
    } else {
      emit(state.copyWith(email: event.recoveryMethod));
      response = await _apiRepository.requestRecoveryCode(
          request: RecoveryCodeRequest(event.recoveryMethod));
    }

    if (response is DataSuccess) {
      _navigationService.goTo(Routes.codeValidation);
    } else {
      // ignore: use_build_context_synchronously
      errorAlertDialog(
        buttonText: 'Ok',
        context: event.context,
        error: response.data?.message,
      );
    }
  }

  Future<void> _validateCode(ValidateCode event, Emitter emit) async {
    final response = await _apiRepository.validateRecoveryCode(
        request: ValidateCodeRequest(event.code));

    if (response is DataSuccess) {
      if (response.data!.status == true) {
        emit(state.copyWith(pin: event.code));
        _navigationService.goTo(Routes.recoverPassword);
      } else {
        // ignore: use_build_context_synchronously
        errorAlertDialog(
          buttonText: 'Ok',
          context: event.context,
          error: response.data!.message,
        );
      }
    }
  }

  _changePassword(ChangePassword event, Emitter emit) async {
    late dynamic response;
    if (event.password.isNotEmpty && event.password == event.confirmPassword) {
      response = await _apiRepository.changePassword(
          request: ChangePasswordRequest(
              code: state.pin!, password: event.password));
    }

    if (response is DataSuccess) {
      if (response.data!.status == true) {
        _navigationService.goTo(Routes.loginRoute);
      } else {
        // ignore: use_build_context_synchronously
        errorAlertDialog(
          buttonText: 'Ok',
          context: event.context,
          error: response.data!.message,
        );
      }
    }
  }
}
