import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import './splash_event.dart';

//service
import '../../../locator.dart';
import '../../../services/storage.dart';

part 'splash_state.dart';

final LocalStorageService _storageService = locator<LocalStorageService>();

class SplashScreenBloc extends Bloc<SplashScreenEvent, SplashScreenState> {
  SplashScreenBloc() : super(Initial()){
    on<HandleNavigateScreenEvent>(_observe);
  }

  void _observe(event, emit) async {
    await Future.delayed(const Duration(seconds: 2));
    await isFirstTime().then((firstTime) async {
      if (firstTime == null || firstTime == false) {
        emit(const Loaded(route: '/politics'));
      } else {
        var token = _storageService.getString('token');
        print(token);
        if (token != null) {
          emit(const Loaded(route: '/home'));
        } else {
          emit(const Loaded(route: '/login'));
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
          yield const Loaded(route: '/politics');
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
      yield const Loaded(route: '/home');
    } else {
      yield const Loaded(route: '/initial');
    }
  }



}