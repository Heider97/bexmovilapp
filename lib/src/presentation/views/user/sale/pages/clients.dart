import 'package:bexmovil/src/presentation/widgets/user/custom_search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

//utils
import '../../../../../utils/constants/strings.dart';
import '../../../../../utils/constants/gaps.dart';

//blocs
import '../../../../blocs/sale/sale_bloc.dart';
import '../../../../blocs/sale_stepper/sale_stepper_bloc.dart';

//features
import '../../../../widgets/atoms/app_text.dart';
import '../widgets/card_client_sale.dart';

//widgets
import '../../../../widgets/atoms/app_back_button.dart';
import '../../../../widgets/atoms/app_icon_button.dart';
import '../../../../widgets/user/stepper.dart';

//services
import '../../../../../locator.dart';
import '../../../../../services/navigation.dart';

final NavigationService navigationService = locator<NavigationService>();

class ClientsPage extends StatefulWidget {
  final String? codeRouter;
  const ClientsPage({super.key, this.codeRouter});

  @override
  State<ClientsPage> createState() => _ClientsPageState();
}

late SaleStepperBloc saleStepperBloc;

class _ClientsPageState extends State<ClientsPage> {
  final TextEditingController searchController = TextEditingController();

  final formatCurrency = NumberFormat.simpleCurrency();

  late SaleBloc saleBloc;

  @override
  void initState() {
    super.initState();
    saleBloc = BlocProvider.of<SaleBloc>(context);
    saleBloc.add(LoadClients(widget.codeRouter));

    saleStepperBloc = BlocProvider.of(context);
  }

  List<StepData> steps = [
    StepData(
        "Seleccionar \nCliente",
        'assets/icons/ProfileEnable.png',
        const Color(0xFFF4F4F4),
        'assets/icons/ProfileDisable.png',
        () => saleStepperBloc.add(ChangeStepEvent(index: 0))),
    StepData(
        "Seleccionar \n Productos",
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
      child: Padding(
        padding: const EdgeInsets.all(Const.space15),
        child: Column(
          children: [
            StepperWidget(currentStep: 0, steps: steps),
            Row(
              children: [
                Expanded(
                  child: CustomSearchBar(
                      onChanged: (value) {},
                      colorBackground: theme.colorScheme.secondary,
                      prefixIcon: const Icon(Icons.search),
                      controller: TextEditingController(),
                      hintText: 'Buscar cliente'),
                ),
                BlocBuilder<SaleBloc, SaleState>(builder: (context, state) {
                  if (state.clients != null && state.clients!.isNotEmpty) {
                    return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: AppIconButton(
                            child: Icon(
                              Icons.map_rounded,
                              color: theme.colorScheme.onPrimary,
                            ),
                            onPressed: () {
                              navigationService.goTo(AppRoutes.saleMap);
                            })
                        /*  context.read<SaleBloc>().add(NavigationSale(
                                clients: state.clients!, nearest: false));
                          }), */
                        );
                  } else {
                    return const Center(child: CupertinoActivityIndicator());
                  }
                }),
                AppIconButton(
                    child: Icon(Icons.filter_alt_rounded,
                        color: theme.colorScheme.onPrimary),
                    onPressed: () => navigationService.goTo(
                          AppRoutes.filtersSale,
                        )),
              ],
            ),
            gapH4,
            BlocBuilder<SaleBloc, SaleState>(
              builder: (context, state) {
                if (state.status == SaleStatus.loading) {
                  return const Center(child: CupertinoActivityIndicator());
                } else if (state.status == SaleStatus.success) {
                  return Expanded(
                    child: ListView.builder(
                        padding: const EdgeInsets.all(Const.padding),
                        itemCount:
                            state.clients != null ? state.clients!.length : 0,
                        itemBuilder: (context, index) {
                          return CardClientRouter(
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
