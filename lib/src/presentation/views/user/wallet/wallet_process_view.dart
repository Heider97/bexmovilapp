import 'package:bexmovil/src/presentation/views/user/wallet/data_grid_checkbox.dart';
import 'package:bexmovil/src/presentation/widgets/global/custom_back_button.dart';
import 'package:bexmovil/src/presentation/widgets/global/custom_frame_button.dart';
import 'package:bexmovil/src/presentation/widgets/global/custom_menu_button.dart';
import 'package:bexmovil/src/presentation/widgets/user/stepper.dart';
import 'package:bexmovil/src/utils/constants/gaps.dart';
import 'package:bexmovil/src/utils/constants/screens.dart';
import 'package:bexmovil/src/utils/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class WalletProcessView extends StatefulWidget {
  const WalletProcessView({super.key});

  @override
  State<WalletProcessView> createState() => _WalletProcessViewState();
}

class _WalletProcessViewState extends State<WalletProcessView> {
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
              children: [
                CustomBackButton(primaryColorBackgroundMode: true),
                CustomMenuButton(
                  primaryColorBackgroundMode: true,
                )
              ],
            ),
          ),
          StepperWidget(
            currentStep: 1,
            steps: [
              StepData("Seleccionar Cliente", Assets.profileEnable,
                  theme.primaryColor, Assets.profileDisable, () {}),
              StepData("Seleccionar facturas", Assets.invoiceEnable,
                  theme.primaryColor, Assets.invoiceDisable, () {}),
              StepData(
                "Realizar Acción",
                Assets.actionEnable,
                theme.primaryColor,
                Assets.actionDisable,
                () {},
              )
            ],
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
                              'Número de factura',
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
          DataGridCheckBox(),
          const Expanded(child: Text('asdasd'))
        ],
      ),
    );
  }
}
