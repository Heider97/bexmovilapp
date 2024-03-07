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

final NavigationService navigationService = locator<NavigationService>();

class WalletSummariesView extends StatefulWidget {
  final WalletArgument? argument;
  const WalletSummariesView({super.key, this.argument});

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
    walletBloc.add(LoadSummaries(
        range: widget.argument!.type, client: widget.argument!.client));
    saleStepperBloc = BlocProvider.of(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(Const.padding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const AppBackButton(needPrimary: true),
                AppText(widget.argument!.type),
                AppIconButton(
                    onPressed: null,
                    child: Icon(Icons.menu,
                        color:
                            Theme.of(context).colorScheme.onPrimaryContainer)),
              ],
            ),
          ),
          // StepperWidget(
          //   currentStep: 0,
          //   steps: [
          //     StepData("Seleccionar\n Cliente", Assets.profileEnable,
          //         theme.primaryColor, Assets.profileDisable, () {
          //           walletBloc.add(SelectClientEvent());
          //         }),
          //     StepData("Seleccionar\n facturas", Assets.invoiceEnable,
          //         theme.primaryColor, Assets.invoiceDisable, () {
          //           walletBloc.add(InvoiceSelectionEvent());
          //         }),
          //     StepData(
          //       "Recaudar",
          //       Assets.actionEnable,
          //       theme.primaryColor,
          //       Assets.actionDisable,
          //           () {
          //         walletBloc.add(InvoiceActionEvent());
          //       },
          //     )
          //   ],
          // ),
          Row(children: [
            Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(Const.padding),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Const.space15)),
                    child: Padding(
                      padding: const EdgeInsets.all(Const.padding),
                      child: Row(
                        children: [
                          Icon(
                            Icons.search,
                          ),
                          gapW24,
                          AppText(
                            'Factura o cliente',
                          )
                        ],
                      ),
                    ),
                  )),
            )
          ]),
          gapH4,
          // Expanded(child: DataGridCheckBox()),
          Material(
            elevation: 10,
            borderRadius: BorderRadius.circular(10),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                width: size.width,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          AppText('2 Facturas', fontWeight: FontWeight.bold),
                          AppText('Abono: \$ 4.509.448',
                              fontWeight: FontWeight.bold),
                          AppText('Total: \$ 9.000.000',
                              fontWeight: FontWeight.bold),
                        ],
                      ),
                      gapW16,
                      Row(children: [
                        AppText('Vaciar'),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                              onPressed: () {
                                //TODO: [Heider Zapa]
                                // _navigationService
                                //     .goTo(AppRoutes.walletDetailsScreen);
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: AppText('Gestionar')),
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
