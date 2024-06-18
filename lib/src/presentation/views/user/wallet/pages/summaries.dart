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
import '../../../../widgets/user/custom_search_bar.dart';
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

class _WalletSummariesViewState extends State<WalletSummariesView> {
  TextEditingController searchController = TextEditingController();

  late WalletBloc walletBloc;

  @override
  void initState() {
    super.initState();
    walletBloc = BlocProvider.of<WalletBloc>(context);
    walletBloc.add(LoadSummaries(
        range: widget.argument!.type, client: widget.argument!.client));
  }

  @override
  void dispose() {
    walletBloc.add(LoadClients(range: widget.argument!.type));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Size size = MediaQuery.of(context).size;

    return BlocBuilder<WalletBloc, WalletState>(builder: (context, state) {
      if (state.status == WalletStatus.loading) {
        return const Center(
            child: CupertinoActivityIndicator(color: Colors.green));
      } else if (state.status == WalletStatus.invoices) {
        return _buildBody(size, theme, state, context);
      } else {
        return const SizedBox();
      }
    });

  }

  Widget _buildBody(
      Size size, ThemeData theme, WalletState state, BuildContext context) {
    return SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: CustomSearchBar(
                        onChanged: (value) {
                          walletBloc.add(SearchClientWallet(valueToSearch: value));
                        },
                        colorBackground: theme.colorScheme.secondary,
                        prefixIcon: const Icon(Icons.search),
                        controller: searchController,
                        hintText: 'Buscar factura'),
                  ),
                  gapW8,
                  AppIconButton(
                      child: Icon(Icons.filter_alt_rounded,
                          color: theme.colorScheme.onPrimary),
                      onPressed: () => navigationService.goTo(
                        AppRoutes.filtersSale,
                      )),
                ],
              ),
            ),
            gapH8,
            //TODO [Heider Zapa]
          ],
        ),
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
                            AppText(textToShow,
                                fontWeight: FontWeight.bold, fontSize: 16),
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
    ));
  }
}
