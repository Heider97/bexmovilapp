import 'package:flutter/material.dart';

//services
import '../../locator.dart';
import '../../services/navigation.dart';
import '../../services/storage.dart';
import '../../services/styled_dialog_controller.dart';

//widgets
import '../../presentation/widgets/atomsbox.dart';

void registerDialogs() {
  locator<StyledDialogController>()
      .registerDialogOf(style: Status.success, builder: showSuccessDialog);
  locator<StyledDialogController>()
      .registerDialogOf(style: Status.loading, builder: showLoadingDialog);
  locator<StyledDialogController>()
      .registerDialogOf(style: Status.error, builder: showErrorDialog);
}

Future<void> showSuccessDialog() {
  final ctx = locator<NavigationService>().navigatorKey.currentState!.context;
  final storageService = locator<LocalStorageService>();

  var title = storageService.getString('dialog_title');
  var description = storageService.getString('dialog_description');
  var image = storageService.getString('dialog_image');

  return showDialog(
      barrierDismissible: true,
      context: ctx,
      builder: (_) => AppGlobalDialog.success(
          title: title ?? '¡Perfecto!',
          description: description,
          image: image));
}

Future<void> showLoadingDialog() {
  final ctx = locator<NavigationService>().navigatorKey.currentState!.context;
  final storageService = locator<LocalStorageService>();

  var title = storageService.getString('dialog_title');
  var description = storageService.getString('dialog_description');
  var image = storageService.getString('dialog_image');

  return showDialog(
      barrierDismissible: false,
      context: ctx,
      builder: (_) => AppGlobalDialog.error(
          title: title ?? 'Cargando...',
          description: description,
          image: image));
}

Future<void> showErrorDialog() {
  final ctx = locator<NavigationService>().navigatorKey.currentState!.context;
  final storageService = locator<LocalStorageService>();

  var title = storageService.getString('dialog_title');
  var description = storageService.getString('dialog_description');
  var image = storageService.getString('dialog_image');

  return showDialog(
      barrierDismissible: false,
      context: ctx,
      builder: (_) => AppGlobalDialog.error(
          title: title ?? 'Error',
          description:
              'Necesitamos saber tu ubicacion,\n activa tu GPS para continuar disfrutando de la APP.',
          image: 'assets/icons/pin.svg'));
}
