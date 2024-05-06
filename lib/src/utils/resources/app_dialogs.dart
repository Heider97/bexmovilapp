import 'package:bexmovil/src/domain/models/client.dart';
import 'package:bexmovil/src/presentation/views/user/sale/widgets/card_client.dart';
import 'package:bexmovil/src/presentation/widgets/user/expanded_section.dart';
import 'package:bexmovil/src/utils/constants/gaps.dart';
import 'package:bexmovil/src/utils/widgets/ShowPriceAndWarehousesAlert.dart';
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

Future<void> showPriceAndWarehouses(BuildContext context,
    {required String codClient,required String nameClient}) {
  return showDialog(
    barrierDismissible: true,
    context: context,
    builder: (_) => ShowPriceAndWarehousesAlert(
      codClient: codClient,
      clientName: nameClient,
    ),
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

class CarouselImageDialog extends StatefulWidget {
  final List<String> productImagesList;

  const CarouselImageDialog({Key? key, required this.productImagesList})
      : super(key: key);

  @override
  _CarouselImageDialogState createState() => _CarouselImageDialogState();
}

class _CarouselImageDialogState extends State<CarouselImageDialog> {
  final CarouselController _controller = CarouselController();
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeData theme = Theme.of(context);
    return Dialog(
      surfaceTintColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: size.height * 0.4,
              enlargeCenterPage: true,
              autoPlay: false,
              aspectRatio: 16 / 9,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              viewportFraction: 1,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              },
            ),
            items: widget.productImagesList.map((image) {
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
          gapH20,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.productImagesList.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => _controller.animateToPage(entry.key),
                child: Container(
                  width: 8.0,
                  height: 8.0,
                  margin: const EdgeInsets.symmetric(
                      vertical: 4.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: /* (Theme.of(context).brightness == Brightness.dark */
                        /*  ? */ Colors.white
                            /*  : theme.primaryColor */ /* ) */
                            .withOpacity(_current == entry.key ? 0.9 : 0.4),
                  ),
                ),
              );
            }).toList(),
          ),
          gapH12
        ],
      ),
    );
  }
}
