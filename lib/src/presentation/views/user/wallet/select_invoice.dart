import 'package:bexmovil/src/locator.dart';
import 'package:bexmovil/src/presentation/views/user/wallet/data_grid_checkbox.dart';
import 'package:bexmovil/src/presentation/widgets/global/custom_frame_button.dart';
import 'package:bexmovil/src/services/navigation.dart';
import 'package:bexmovil/src/utils/constants/gaps.dart';
import 'package:bexmovil/src/utils/constants/screens.dart';
import 'package:bexmovil/src/utils/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final NavigationService _navigationService = locator<NavigationService>();

class SelectInvoice extends StatelessWidget {
  const SelectInvoice({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Expanded(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: Screens.width(context),
              child: Card(
                surfaceTintColor: theme.primaryColor,
                color: theme.primaryColor,
                child: const Padding(
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
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                    padding: const EdgeInsets.all(Const.padding),
                    child: Container(
                      decoration: BoxDecoration(
                          color: theme.colorScheme.secondary,
                          borderRadius: BorderRadius.circular(Const.space15)),
                      child: Padding(
                        padding: const EdgeInsets.all(Const.padding),
                        child: Row(
                          children: [
                            Icon(
                              Icons.search,
                              color: theme.colorScheme.tertiary,
                            ),
                            gapW24,
                            Text(
                              'Factura o cliente',
                              style:
                                  TextStyle(color: theme.colorScheme.tertiary),
                            )
                          ],
                        ),
                      ),
                    )),
              ),
              const CustomFrameButtom(
                  icon: FontAwesomeIcons.locationArrow,
                  primaryColorBackgroundMode: true),
              gapW8,
              const CustomFrameButtom(
                  icon: Icons.tune, primaryColorBackgroundMode: true),
              gapW8,
            ],
          ),
          Expanded(child: DataGridCheckBox()),
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
                          Text('2 Facturas',
                              style: theme.textTheme.bodyLarge!
                                  .copyWith(fontWeight: FontWeight.bold)),
                          const Text('Abono: \$ 4.509.448'),
                          const Text('Total: \$ 9.000.000')
                        ],
                      ),
                      gapW16,
                      Row(children: [
                        Text('Vaciar',
                            style: theme.textTheme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.bold,
                                color: theme.primaryColor)),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () {
                              _navigationService
                                  .goTo(Routes.walletDetailsScreen);
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: theme.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              'Gestionar',
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
