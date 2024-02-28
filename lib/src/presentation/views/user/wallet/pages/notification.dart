import 'package:bexmovil/src/presentation/widgets/global/custom_back_button.dart';
import 'package:geolocator/geolocator.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'package:bexmovil/src/utils/constants/screens.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WalletNotificationView extends StatefulWidget {
  const WalletNotificationView({super.key});

  @override
  State<WalletNotificationView> createState() => _WalletNotificationViewState();
}

class _WalletNotificationViewState extends State<WalletNotificationView> {
  final GlobalKey<SfSignaturePadState> signatureGlobalKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _handleClearButtonPressed() {
    signatureGlobalKey.currentState!.clear();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomBackButton(primaryColorBackgroundMode: true),
                SizedBox()
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: Screens.width(context),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(FontAwesomeIcons.whatsapp),
                        Icon(FontAwesomeIcons.solidMessage),
                        Icon(FontAwesomeIcons.google)
                      ],
                    ),
                  ),
                  const Expanded(
                    child: SizedBox(),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey)),
                        child: Stack(
                          children: [
                            SfSignaturePad(
                                key: signatureGlobalKey,
                                backgroundColor: Colors.white,
                                strokeColor: Colors.black,
                                minimumStrokeWidth: 1.0,
                                maximumStrokeWidth: 4.0),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: TextButton(
                                onPressed: _handleClearButtonPressed,
                                child: Text('Limpiar'),
                              ),
                            ),
                          ],
                        ),
                      )),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: Screens.width(context),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          /*    _navigationService
                              .goTo(Routes.walletNotificationView); */
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: theme.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'Enviar',
                          style: theme.textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w600, color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
