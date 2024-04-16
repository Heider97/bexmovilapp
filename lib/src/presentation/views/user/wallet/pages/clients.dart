import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//utils

import '../../../../../utils/constants/gaps.dart';
import '../../../../../utils/constants/strings.dart';

//blocs
import '../../../../blocs/wallet/wallet_bloc.dart';
import '../../../../blocs/sale_stepper/sale_stepper_bloc.dart';

//domain
import '../../../../../domain/models/arguments.dart';

//atoms

import '../../../../widgets/user/custom_search_bar.dart';
import '../widgets/card_client_wallet.dart';
import '../../../../widgets/atomsbox.dart';
import '../../../../widgets/user/stepper.dart';

//services
import '../../../../../locator.dart';
import '../../../../../services/navigation.dart';

final NavigationService navigationService = locator<NavigationService>();

class WalletClientsView extends StatefulWidget {
  final WalletArgument? argument;
  const WalletClientsView({super.key, this.argument});

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
    walletBloc.add(LoadClients(range: widget.argument!.type));
    saleStepperBloc = BlocProvider.of(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(Const.padding),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const AppBackButton(needPrimary: true),
                AppText(widget.argument!.type),
                Wrap(
                  spacing: 1,
                  children: [
                    /*   AppIconButton(
                      onPressed: () {
                        walletBloc.navigationService.goTo(AppRoutes.notificationWallet);
                      },
                      child: Icon(Icons.notification_add),
                    ), */
                    AppIconButton(
                        onPressed: null,
                        child: Icon(Icons.menu,
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer)),
                  ],
                )
              ],
            ),
            // StepperWidget(
            //   currentStep: 0,
            //   steps: [
            //     StepData("Seleccionar\n Cliente", Assets.profileEnable,
            //         theme.primaryColor, Assets.profileDisable, () {
            //       walletBloc.add(SelectClientEvent());
            //     }),
            //     StepData("Seleccionar\n facturas", Assets.invoiceEnable,
            //         theme.primaryColor, Assets.invoiceDisable, () {
            //       walletBloc.add(InvoiceSelectionEvent());
            //     }),
            //     StepData(
            //       "Recaudar",
            //       Assets.actionEnable,
            //       theme.primaryColor,
            //       Assets.actionDisable,
            //       () {
            //         walletBloc.add(InvoiceActionEvent());
            //       },
            //     )
            //   ],
            // ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomSearchBar(
                        prefixIcon: const Icon(
                          Icons.search,
                        ),
                        controller: searchController,
                        hintText: 'Nombre o código del producto'),
                  ),
                ),
              ],
            ),
            gapH4,
            BlocBuilder<WalletBloc, WalletState>(
              builder: (context, state) {
                if (state.status == WalletStatus.loading) {
                  return const Center(child: CupertinoActivityIndicator());
                } else if (state.canRenderView()) {
                  return Expanded(
                    child: ListView.builder(
                        itemCount:
                            state.clients != null ? state.clients!.length : 0,
                        itemBuilder: (context, index) {
                          return CardClientWallet(
                            onTap: () {
                              walletBloc.navigationService.goTo(
                                  AppRoutes.summariesWallet,
                                  arguments: WalletArgument(
                                      type: widget.argument!.type,
                                      client: state.clients![index]));
                            },
                            client: state.clients![index],
                          );
                        }),
                  );
                } else {
                  return Center(child: AppText("No se encontraron clientes."));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
