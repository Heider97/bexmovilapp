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

class WalletClientsView extends StatefulWidget {
  final WalletArgument? walletArgument;
  const WalletClientsView({super.key, this.walletArgument});

  @override
  State<WalletClientsView> createState() => _WalletClientsViewState();
}

late SaleStepperBloc saleStepperBloc;

class _WalletClientsViewState extends State<WalletClientsView> {
  TextEditingController searchController = TextEditingController();

  late WalletBloc walletBloc;

  @override
  void initState() {
    walletBloc = BlocProvider.of<WalletBloc>(context);
    // walletBloc.add(LoadGraphics());
    saleStepperBloc = BlocProvider.of(context);
    super.initState();
  }

  List<StepData> steps = [
    StepData(
        "Seleccionar \nCliente",
        'assets/icons/ProfileEnable.png',
        const Color(0xFFF4F4F4),
        'assets/icons/ProfileDisable.png',
        () => saleStepperBloc.add(ChangeStepEvent(index: 0))),
    StepData(
        "Seleccionar \n Facturas",
        'assets/icons/seleccionarFacturaEnable.png',
        const Color(0xFFF4F4F4),
        'assets/icons/seleccionarFacturaDisable.png',
        () => saleStepperBloc.add(ChangeStepEvent(index: 1))),
    StepData(
        'Detalles de \n la orden',
        'assets/icons/actionEnable.png',
        const Color(0xFFF4F4F4),
        'assets/icons/actionDisable.png',
        () => saleStepperBloc.add(ChangeStepEvent(index: 2))),
  ];

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return SafeArea(
      child: SingleChildScrollView(
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
            StepperWidget(currentStep: 0, steps: steps),
            Padding(
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
                          'Búsqueda por clientes',
                          style: TextStyle(color: theme.colorScheme.tertiary),
                        )
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
