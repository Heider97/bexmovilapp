import 'dart:io';

import 'package:bexmovil/src/domain/models/client.dart';
import 'package:bexmovil/src/presentation/views/user/sale/widgets/card_client.dart';
import 'package:carousel_slider/carousel_slider.dart';
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

showClientDialog({required BuildContext context, required Client client}) {
  return showDialog(
      context: context,
      builder: (_) {
        Size size = MediaQuery.of(context).size;
        ThemeData theme = Theme.of(context);
        return Dialog(
            backgroundColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            /*    shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))), */
            child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CardClient(
                    client: client,
                  )
                ]));
      });
}

showCarouselImageDialog(
    {required BuildContext context, required List<String> productImagesList}) {
  return showDialog(
      context: context,
      builder: (_) {
        Size size = MediaQuery.of(context).size;
        ThemeData theme = Theme.of(context);
        return Dialog(
          /*   backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent, */
          surfaceTintColor: Colors.white,
          /*    shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))), */

          child: CarouselSlider(
            options: CarouselOptions(
              height:
                  size.height * 0.5, // Ajusta la altura según tus necesidades
              enlargeCenterPage: true,
              autoPlay: false, // Auto reproducción
              aspectRatio: 16 / 9, // Relación de aspecto de las imágenes
              autoPlayCurve: Curves.fastOutSlowIn, // Curva de animación
              enableInfiniteScroll: true, // Desplazamiento infinito
              autoPlayAnimationDuration:
                  Duration(milliseconds: 800), // Duración de la animación
              viewportFraction:
                  0.8, // Fracción de la pantalla ocupada por el elemento visible
            ),
            items: productImagesList.map((image) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Image.asset(image, fit: BoxFit.contain),
                  );
                },
              );
            }).toList(),
          ),
        );
      });
}
