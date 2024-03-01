part of '../index.dart';

extension SnackBarWidget on LoginViewState {
  ScaffoldFeatureController buildSnackBar(BuildContext context, String text) {
    return ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(key: const Key('LoginFailure'), content: Text(text)));
  }
}