import 'dart:async';
import 'package:bexmovil/src/utils/constants/strings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

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
        if (token != null) {
          emit(const Loaded(route: Routes.homeRoute));
        } else {
          emit(const Loaded(route: Routes.selectEnterpriseRoute));
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
          yield const Loaded(route: Routes.politicsRoute);
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
    if (token != null) {
      yield const Loaded(route: Routes.homeRoute);
    } else {
      yield const Loaded(route: Routes.selectEnterpriseRoute);
    }
  }
}
