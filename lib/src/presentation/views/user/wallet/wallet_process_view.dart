import 'package:bexmovil/src/locator.dart';
import 'package:bexmovil/src/presentation/views/user/wallet/select_client.dart';
import 'package:bexmovil/src/presentation/views/user/wallet/select_invoice.dart';
import 'package:bexmovil/src/presentation/views/user/wallet/wallet_action.dart';

import 'package:bexmovil/src/presentation/widgets/user/stepper.dart';
import 'package:bexmovil/src/services/navigation.dart';
import 'package:bexmovil/src/utils/constants/gaps.dart';

import 'package:bexmovil/src/utils/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/wallet/wallet_bloc.dart';

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
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // const CustomBackButton(primaryColorBackgroundMode: true),
                // Row(
                //   children: [
                //     CustomFrameButtom(
                //       icon: Icons.notification_add,
                //       onTap: () {
                //         print('HELLOW');
                //         _navigationService.goTo(Routes.walletNotificationView);
                //       },
                //     ),
                //     gapW8,
                //     const CustomMenuButton(
                //       primaryColorBackgroundMode: true,
                //     ),
                //   ],
                // )
              ],
            ),
          ),
          StepperWidget(
            currentStep: 1,
            steps: [
              StepData("Seleccionar\n Cliente", Assets.profileEnable,
                  theme.primaryColor, Assets.profileDisable, () {
                walletBloc.add(SelectClientEvent());
              }),
              StepData("Seleccionar\n facturas", Assets.invoiceEnable,
                  theme.primaryColor, Assets.invoiceDisable, () {
                walletBloc.add(InvoiceSelectionEvent());
              }),
              StepData(
                "Recaudar",
                Assets.actionEnable,
                theme.primaryColor,
                Assets.actionDisable,
                () {
                  walletBloc.add(InvoiceActionEvent());
                },
              )
            ],
          ),
          BlocBuilder<WalletBloc, WalletState>(
            builder: (context, state) {
              //TODO: [Heider Zapa] ajust event of copy state wallet bloc
              // if (state is WalletStepperClientSelection) {
              //   return const SelectClientWallet();
              // } else if (state is WalletStepperInvoiceSelection) {
              //   return const SelectInvoice();
              // } else if (state is WalletStepperInvoiceAction) {
              //   return const WalletActionList();
              // } else {
              //   return const SelectClientWallet();
              // }
              return const SizedBox();
            },
          )
        ],
      ),
    );
  }
}
