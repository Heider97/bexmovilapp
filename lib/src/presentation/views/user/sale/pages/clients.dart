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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const AppBackButton(needPrimary: true),
                AppIconButton(
                    onPressed: () => Scaffold.of(context).openDrawer(),
                    child: const Icon(Icons.menu))
              ],
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
            gapH4,
            BlocBuilder<SaleBloc, SaleState>(
              builder: (context, saleState) {
                if (saleState is SaleInitial) {
                  return Expanded(
                    child: ListView.builder(
                        itemCount: saleState.clients.length,
                        itemBuilder: (context, index) {
                          return CardClientRouter(
                            nit: saleState.clients[index].nitCliente.toString(),
                            addressClient:
                                saleState.clients[index].dirCliente.toString(),
                            branchClient: saleState
                                .clients[index].sucursalCliente
                                .toString(),
                            nameClient:
                                saleState.clients[index].nomCliente.toString(),
                          );
                        }),
                  );
                } else {
                  return const Center(child: Text("Not Found"));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
