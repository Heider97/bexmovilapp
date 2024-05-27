import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

//utils
import '../../../utils/constants/strings.dart';

//service
import '../../../locator.dart';
import '../../../services/storage.dart';

part 'splash_event.dart';
part 'splash_state.dart';

final LocalStorageService _storageService = locator<LocalStorageService>();

class SplashScreenBloc extends Bloc<SplashScreenEvent, SplashScreenState> {
  SplashScreenBloc() : super(Initial()) {
    on<HandleNavigateScreenEvent>(_observe);
  }

  void _observe(event, emit) async {
    await Future.delayed(const Duration(seconds: 2));
    await isFirstTime().then((firstTime) async {
      if (firstTime == null || firstTime == false) {
        emit(const Loaded(route: '/politics'));
      } else {
        var token = _storageService.getString('token');
        var company = _storageService.getObject('enterprise');
        if (token != null) {
          emit(const Loaded(route: AppRoutes.home));
        } else if (company != null) {
          emit(const Loaded(route: AppRoutes.login));
        } else {
          emit(const Loaded(route: AppRoutes.language));
        }
      }
    });
  }

  Stream<SplashScreenState> mapEventToState(
    SplashScreenEvent event,
  ) async* {
    if (event is HandleNavigateScreenEvent) {
      yield Loading();
      await Future.delayed(const Duration(seconds: 3));
      isFirstTime().then((firstTime) async* {
        if (!firstTime!) {
          yield const Loaded(route: AppRoutes.politics);
        } else {
          validateSession();
        }
      });
    }
  }

  Future<bool?> isFirstTime() async {
    return _storageService.getBool('first_time');
  }

  Stream<Loaded> validateSession() async* {
    var token = _storageService.getString('token');
    var company = _storageService.getObject('company');
    if (token != null) {
      yield const Loaded(route: AppRoutes.home);
    } else if (company != null) {
      yield const Loaded(route: AppRoutes.login);
    } else {
      yield const Loaded(route: AppRoutes.language);
    }
  }
}
