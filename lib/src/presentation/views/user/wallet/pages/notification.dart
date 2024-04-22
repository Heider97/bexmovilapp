import 'package:bexmovil/src/presentation/blocs/wallet/wallet_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'package:flutter/material.dart';

//utils
import '../../../../../utils/constants/screens.dart';
import '../../../../../utils/constants/strings.dart';

//widgets
import '../../../../widgets/atoms/app_back_button.dart';
import '../widgets/check_image.dart';

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
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [AppBackButton(needPrimary: true), SizedBox()],
            ),
          ),
          Expanded(
            child: Container(
              width: Screens.width(context),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  BlocBuilder<WalletBloc, WalletState>(
                    builder: (context, state) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: Screens.width(context),
                          child: Card(
                            surfaceTintColor: theme.primaryColor,
                            color: theme.primaryColor,
                            child: Padding(
                              padding: EdgeInsets.all(20),
                              child: Text(
                               'Nombre del cliente',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        /*   Expanded(
                          child: CheckImage(
                              imageFromAsset: Assets.whatsapp,
                              text: "WhatsApp"),
                        ),
                        Expanded(
                          child: CheckImage(
                              imageFromAsset: Assets.textMessage,
                              text: "Mensaje de texto"),
                        ), */
                        CheckImage(
                            imageFromAsset: Assets.emailWallet,
                            text: "correo electronico "),
                        SizedBox()
                      ],
                    ),
                  ),
                  /* const Expanded(
                    child: SizedBox(),
                  ), */
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text('Adjuntar Firma:'),
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
                  const Expanded(
                    child: SizedBox(),
                  ),
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
