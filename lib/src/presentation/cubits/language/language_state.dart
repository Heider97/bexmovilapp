part of 'language_cubit.dart';

enum LanguageStatus { initial, loading, success, failure }

extension LanguageStatusX on LanguageStatus {
  bool get isInitial => this == LanguageStatus.initial;
  bool get isLoading => this == LanguageStatus.loading;
  bool get isSuccess => this == LanguageStatus.success;
  bool get isFailure => this == LanguageStatus.failure;
}

abstract class LanguageState extends Equatable {
  final Locale? language;
  final String? error;
  final LanguageStatus? status;

  const LanguageState({this.language, this.status, this.error});

  List<Object?> get props => [language, status, error];
}

class LanguageInitial extends LanguageState {
  const LanguageInitial(
      {super.status = LanguageStatus.initial,
      super.language = const Locale('es', '')});
}

class LanguageLoading extends LanguageState {
  const LanguageLoading({super.status = LanguageStatus.loading});
}

class LanguageSuccess extends LanguageState {
  const LanguageSuccess(
      {super.status = LanguageStatus.success, super.language});
}

class LanguageFailed extends LanguageState {
  const LanguageFailed(
      {super.status = LanguageStatus.failure, super.language, super.error});
}
