import 'package:bexmovil/src/locator.dart';
import 'package:bexmovil/src/presentation/blocs/wallet_bloc/wallet_bloc.dart';
import 'package:bexmovil/src/presentation/views/user/wallet/data_grid_checkbox.dart';
import 'package:bexmovil/src/presentation/views/user/wallet/select_client.dart';
import 'package:bexmovil/src/presentation/views/user/wallet/select_invoice.dart';
import 'package:bexmovil/src/presentation/views/user/wallet/wallet_action.dart';
import 'package:bexmovil/src/presentation/widgets/global/custom_back_button.dart';
import 'package:bexmovil/src/presentation/widgets/global/custom_button.dart';
import 'package:bexmovil/src/presentation/widgets/global/custom_elevated_button.dart';
import 'package:bexmovil/src/presentation/widgets/global/custom_frame_button.dart';
import 'package:bexmovil/src/presentation/widgets/global/custom_menu_button.dart';
import 'package:bexmovil/src/presentation/widgets/user/stepper.dart';
import 'package:bexmovil/src/services/navigation.dart';
import 'package:bexmovil/src/utils/constants/gaps.dart';
import 'package:bexmovil/src/utils/constants/screens.dart';

import 'package:bexmovil/src/utils/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final NavigationService _navigationService = locator<NavigationService>();

class WalletProcessView extends StatefulWidget {
  const WalletProcessView({super.key});

  @override
  State<WalletProcessView> createState() => _WalletProcessViewState();
}

class _WalletProcessViewState extends State<WalletProcessView> {
  late WalletBloc walletBloc;
  @override
  void initState() {
    walletBloc = BlocProvider.of<WalletBloc>(context);
    super.initState();
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
                  theme.primaryColor, Assets.profileDisable, () {
                walletBloc.add(SelectClientEvent());

                print('Seleccionar cliente');
              }),
              StepData("Seleccionar facturas", Assets.invoiceEnable,
                  theme.primaryColor, Assets.invoiceDisable, () {
                walletBloc.add(InvoiceSelectionEvent());
                print('Seleccionar facturas');
              }),
              StepData(
                "Realizar Acción",
                Assets.actionEnable,
                theme.primaryColor,
                Assets.actionDisable,
                () {
                  walletBloc.add(InvoiceActionEvent());
                  print('Realizar Accion');
                },
              )
            ],
          ),
          BlocBuilder<WalletBloc, WalletState>(
            builder: (context, state) {
              if (state is WalletStepperClientSelection) {
                return const SelectClientWallet();
              } else if (state is WalletStepperInvoiceSelection) {
                return const SelectInvoice();
              } else if (state is WalletStepperInvoiceAction) {
                return WalletActionList();
              } else {
                return Container(
                  child: Text("InvoiceAction"),
                );
              }
            },
          )
        ],
      ),
    );
  }
}
