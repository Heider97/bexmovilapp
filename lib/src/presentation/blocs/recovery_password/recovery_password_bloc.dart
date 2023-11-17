import 'package:bexmovil/src/domain/models/requests/recovery_code.dart';
import 'package:bexmovil/src/domain/repositories/api_repository.dart';
import 'package:bexmovil/src/utils/resources/data_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'recovery_password_event.dart';
part 'recovery_password_state.dart';

class RecoveryPasswordBloc
    extends Bloc<RecoveryPasswordEvent, RecoveryPasswordState> {
  final ApiRepository _apiRepository;

  RecoveryPasswordBloc(this._apiRepository) : super(RecoveryPasswordInitial()) {
    on<StartRecovery>(_startRecovery);
    on<RequestCode>(_requestCode);
  }

  _startRecovery(StartRecovery event, Emitter emit) {
    emit(const RecoveryPasswordLoading());
    emit(StartRecoveryState(type: event.type));
  }

  _requestCode(RequestCode event, Emitter emit) async {
    final response = await _apiRepository.requestRecoveryCode(
        request: RecoveryCodeRequest(event.email));
    if (response is DataSuccess) {
      print('DONE');
    } else {
      print('ERROR');
    }

    //emit(StartRecoveryState(type: event.type));
  }
}
