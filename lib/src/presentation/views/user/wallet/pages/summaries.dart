import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//utils
import '../../../../../utils/constants/gaps.dart';
import '../../../../../utils/constants/strings.dart';

//blocs
import '../../../../blocs/wallet/wallet_bloc.dart';

//domain
import '../../../../../domain/models/arguments.dart';

//atoms
import '../../../../blocs/sale_stepper/sale_stepper_bloc.dart';
import '../../../../widgets/atomsbox.dart';
import '../../../../widgets/user/stepper.dart';

//services
import '../../../../../locator.dart';
import '../../../../../services/navigation.dart';
import '../select_client.dart';
import '../select_invoice.dart';
import '../wallet_action.dart';

final NavigationService navigationService = locator<NavigationService>();

class WalletSummariesView extends StatefulWidget {
  final WalletArgument? walletArgument;
  const WalletSummariesView({super.key, this.walletArgument});

  @override
  State<WalletSummariesView> createState() => _WalletSummariesViewState();
}

late SaleStepperBloc saleStepperBloc;

class _WalletSummariesViewState extends State<WalletSummariesView> {
  TextEditingController searchController = TextEditingController();

  late WalletBloc walletBloc;

  @override
  void initState() {
    walletBloc = BlocProvider.of<WalletBloc>(context);
    // walletBloc.add(LoadGraphics());
    saleStepperBloc = BlocProvider.of(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(Const.padding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const AppBackButton(needPrimary: true),
                AppText(widget.walletArgument!.type),
                AppIconButton(
                    onPressed: null,
                    child: Icon(Icons.menu,
                        color: Theme.of(context)
                            .colorScheme
                            .onPrimaryContainer)),
              ],
            ),
          ),
          StepperWidget(
            currentStep: 0,
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
          gapH4,
          BlocBuilder<WalletBloc, WalletState>(
            builder: (context, state) {
              //TODO: [Heider Zapa] ajust event of copy state wallet bloc
              if (state.status == WalletStatus.client) {
                return const SelectClientWallet();
              } else if (state.status == WalletStatus.invoice) {
                return const SelectInvoice();
              } else if (state.status == WalletStatus.collection) {
                return const WalletActionList();
              } else {
                return const SelectClientWallet();
              }
              return const SizedBox();
            },
          )
        ],
      ),
    );
  }
}
