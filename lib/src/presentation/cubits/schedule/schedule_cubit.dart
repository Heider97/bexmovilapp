import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';

//domain
import '../../../domain/repositories/database_repository.dart';

//service
import '../../../locator.dart';
import '../../../services/storage.dart';
import '../../../services/navigation.dart';

part 'schedule_state.dart';

final LocalStorageService _storageService = locator<LocalStorageService>();
final NavigationService _navigationService = locator<NavigationService>();

class ScheduleCubit extends Cubit<ScheduleState> {
  final DatabaseRepository _databaseRepository;

  ScheduleCubit(this._databaseRepository) : super(const ScheduleLoading());

  Future<void> init() async {


    emit(const ScheduleSuccess());
  }

  void dispose() {
    emit(const ScheduleLoading());
  }

  void back() => _navigationService.goBack();

}