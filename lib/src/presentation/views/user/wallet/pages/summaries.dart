import 'package:bexmovil/src/domain/models/invoice.dart';
import 'package:bexmovil/src/utils/constants/screens.dart';
import 'package:bexmovil/src/utils/extensions/string_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//utils
import '../../../../../utils/constants/gaps.dart';
import '../../../../../utils/constants/strings.dart';

//blocs
import '../../../../blocs/wallet/wallet_bloc.dart';
import '../../../../blocs/sale_stepper/sale_stepper_bloc.dart';

//domain
import '../../../../../domain/models/arguments.dart';

//widgets
import '../../../../widgets/atomsbox.dart';
import '../widgets/table_summaries_wallet.dart';
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
    ThemeData theme = Theme.of(context);
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
                          const Icon(
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: Screens.width(context),
              child: Card(
                surfaceTintColor: theme.primaryColor,
                color: theme.primaryColor,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    widget.argument!.client!.name!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
          gapH4,

          BlocBuilder<WalletBloc, WalletState>(
            builder: (context, state) {
              if (state.status == WalletStatus.loading) {
                return const Center(child: CupertinoActivityIndicator());
              } else if (state.canRenderView()) {
                return Expanded(
                    child:
                        WalletTableSummaries(invoices: state.invoices ?? []));
              } else {
                return Center(child: AppText("No se encontraron facturas."));
              }
            },
          ),
          // Expanded(child: DataGridCheckBox()),
          BlocBuilder<WalletBloc, WalletState>(
            builder: (context, state) {
              int totalAbono = state.invoices?.fold(
                      0, (sum, invoice) => sum! + (invoice.preciomov ?? 0)) ??
                  0;

              String textToShow = '';

              if (state.invoices != null) {
                if (state.invoices!.length == 1) {
                  textToShow = '1 Factura';
                } else {
                  textToShow = '${state.invoices!.length} Facturas';
                }
              } else {
                textToShow = 'No hay facturas';
              }

              return Material(
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /*   AppText('${state.invoices!.length} Facturas'), */
                              AppText(textToShow,fontWeight: FontWeight.bold,fontSize: 20,),
                              /*      AppText(
                                  'Abono: \$ ${''.formatted(totalAbono.toDouble())}'), */
                              AppText(
                                  'Total: \$ ${''.formatted(totalAbono.toDouble())}'),
                            ],
                          ),
                          gapW12,
                          Row(children: [
                            AppText('Vaciar'),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                  onPressed: () {
                                    //TODO: [Heider Zapa]
                                    //TODO: navigate realizar accion
                                    navigationService
                                        .goTo(AppRoutes.actionWallet);
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
              );
            },
          )
        ],
      ),
    );
  }
}
