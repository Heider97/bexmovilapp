import 'package:flutter/material.dart';

class Language {
  final String name;
  final String flag;
  final String languageCode;
  Language(this.name, this.flag, this.languageCode);
  static List<Language> languageList() {
    return <Language>[
      Language('English', 'US', 'en'),
      Language('Español', 'AR', 'es'),
    ];
  }
}
const String english = "en";
const String spanish = "es";
//Function for selecting the language from the given option
Locale changeLanguage(Language language, context) {
  Locale a;
  switch (language.languageCode) {
    case english:
      a = Locale(language.languageCode, "US");
      break;
    case spanish:
      a = Locale(language.languageCode, 'AR');
      break;
    default:
      a = Locale(language.languageCode, 'US');
  }
  return a;
}