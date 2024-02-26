import 'package:bexmovil/src/locator.dart';
import 'package:bexmovil/src/presentation/widgets/global/custom_back_button.dart';
import 'package:bexmovil/src/presentation/widgets/global/custom_menu_button.dart';
import 'package:bexmovil/src/presentation/widgets/global/custom_textformfield.dart';
import 'package:bexmovil/src/services/navigation.dart';
import 'package:bexmovil/src/utils/constants/gaps.dart';
import 'package:bexmovil/src/utils/constants/screens.dart';
import 'package:bexmovil/src/utils/constants/strings.dart';
import 'package:bexmovil/src/utils/validators.dart';
import 'package:flutter/material.dart';

final NavigationService _navigationService = locator<NavigationService>();

class WalletDetailsScreen extends StatelessWidget {
  const WalletDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomBackButton(primaryColorBackgroundMode: true),
                    CustomMenuButton(
                      primaryColorBackgroundMode: true,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: Screens.width(context),
                  child: Card(
                    elevation: 10,
                    surfaceTintColor: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text.rich(
                              TextSpan(
                                children: [
                                  const TextSpan(text: 'Estado: '),
                                  TextSpan(
                                    text: 'Mora',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: theme.colorScheme.error),
                                  ),
                                ],
                              ),
                            ),
                            const Text('Dias de vencimiento: 30'),
                            const Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(text: 'Factura: '),
                                  TextSpan(
                                    text: 'IOST415D',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Text(
                                'Visitado por última vez: 24/agosto/2022'),
                            const Text('valor: \$ 4.509.448 '),
                          ]),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(Const.space18),
                child: Text(
                  "Detalles del pago",
                  style: theme.textTheme.bodyLarge!
                      .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: Const.space18),
                child: Text("Abono : "),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: Const.space18,
                  right: Const.space18,
                  top: 8,
                ),
                child: SizedBox(
                  width: Screens.width(context),
                  child: CustomTextFormField(
                    controller: TextEditingController(),
                    hintText: 'Cantidad a abonar',
                    validator: Validator().number,
                  ),
                ),
              )
            ],
          ),
          Material(
            elevation: 10,
            borderRadius: BorderRadius.circular(10),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                width: Screens.width(context),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text('Total',
                              style: theme.textTheme.bodyLarge!
                                  .copyWith(fontWeight: FontWeight.bold)),
                          Text('\$ 450.000.000',
                              style: theme.textTheme.bodyLarge!
                                  .copyWith(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      gapW16,
                      Row(children: [
                        Text('volver',
                            style: theme.textTheme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.bold,
                                color: theme.primaryColor)),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () {
                              _navigationService
                                  .goTo(Routes.walletNotificationView);
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: theme.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              'Guardar',
                              style: theme.textTheme.bodyMedium!.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ])
                    ]),
              ),
            ),
          )
        ],
      ),
    );
  }
}
