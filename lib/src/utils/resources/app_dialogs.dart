import 'package:flutter/material.dart';

//services
import '../../locator.dart';
import '../../services/navigation.dart';
import '../../services/storage.dart';
import '../../services/styled_dialog_controller.dart';

//widgets
import '../../presentation/widgets/atomsbox.dart';

//modals
import './modals/product_info.dart';
import './modals/warehouses_and_prices.dart';

void registerDialogs() {
  locator<StyledDialogController>()
      .registerDialogOf(style: Status.success, builder: showSuccessDialog);

  locator<StyledDialogController>()
      .registerDialogOf(style: Status.loading, builder: showLoadingDialog);

  locator<StyledDialogController>()
      .registerDialogOf(style: Status.error, builder: showErrorDialog);

  locator<StyledDialogController>().registerDialogOf(
      style: Status.gpsDisabled, builder: showGpsDisabledDialog);

  locator<StyledDialogController>().registerDialogOf(
      style: Status.clientInfo, builder: showClientInfoDialog);

  locator<StyledDialogController>().registerDialogOf(
      style: Status.warehouseAndPrices, builder: showPriceAndWarehousesDialog);

  locator<StyledDialogController>().registerDialogOf(
      style: Status.productInfo, builder: showProductInfoDialog);
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

Future<void> showPriceAndWarehousesDialog() {
  final ctx = locator<NavigationService>().navigatorKey.currentState!.context;

  return showDialog(
    barrierDismissible: true,
    context: ctx,
    builder: (_) => const ModalWarehousesAndPrices(),
  );
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
          title: title ?? 'Active su GPS',
          description: description,
          image: image!));
}

Future<void> showGpsDisabledDialog() {
  final ctx = locator<NavigationService>().navigatorKey.currentState!.context;

  return showDialog(
      barrierDismissible: false,
      context: ctx,
      builder: (_) => AppGlobalDialog.error(
          title: 'Active su GPS',
          description:
              'Necesitamos saber tu ubicacion,\n activa tu GPS para continuar disfrutando de la APP.',
          image: 'assets/icons/pin.svg'));
}

Future<void> showProductInfoDialog() {
  final ctx = locator<NavigationService>().navigatorKey.currentState!.context;

  return showDialog(
      barrierDismissible: true,
      context: ctx,
      builder: (_) => const ModalProductInfo());
}

Future<void> showClientInfoDialog() {
  final ctx = locator<NavigationService>().navigatorKey.currentState!.context;

  return showDialog(
      context: ctx,
      builder: (_) {
        return const Dialog(
            backgroundColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: []));
      });
}
