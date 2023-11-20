import 'package:bexmovil/src/domain/models/requests/recovery_code.dart';
import 'package:bexmovil/src/domain/repositories/api_repository.dart';
import 'package:bexmovil/src/locator.dart';

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
      //TODO CHANGE ALERT
      showDialog(
          context: event.context,
          builder: (BuildContext context) => AlertDialog(
                title: Text('Title'),
                content: SizedBox(
                  height: 180,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Icon(
                        Icons.error,
                        color: Colors.orange,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text('Title'),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: 300,
                        child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.orange,
                            ),
                            onPressed: () {},
                            child: Text(
                              'Title',
                              style: const TextStyle(color: Colors.white),
                            )),
                      )
                    ],
                  ),
                ),
                elevation: 10,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ));

      emit(state.copyWith(error: response.error));
    }
  }
}
