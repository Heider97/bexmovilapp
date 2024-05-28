import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

//utils
import '../../../utils/constants/strings.dart';

//services
import '../../../services/storage.dart';
import '../../../services/navigation.dart';


part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  final LocalStorageService storageService;
  final NavigationService navigationService;

  LanguageCubit(this.storageService, this.navigationService) : super(const LanguageInitial());

  void selectLang(context, code) {
    emit(LanguageSuccess(status: LanguageStatus.success, language: Locale(code, '')));
  }

  void changeLang(context, Locale language) async {
    emit(LanguageSuccess(status: LanguageStatus.success, language: language));
    storageService.setString('language', language.languageCode);
    navigationService.goTo(AppRoutes.selectEnterprise);
  }
}
