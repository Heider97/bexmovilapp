import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

//utils
import '../../../../../utils/constants/strings.dart';
import '../../../../../utils/constants/gaps.dart';

//blocs
import '../../../../blocs/sale/sale_bloc.dart';
import '../../../../blocs/sale_stepper/sale_stepper_bloc.dart';

//cubit
import '../../../../cubits/home/home_cubit.dart';

//widgets
import '../../../../widgets/atoms/app_back_button.dart';
import '../../../../widgets/atoms/app_icon_button.dart';
import '../../../../widgets/user/stepper.dart';

//features
import '../widgets/card_router_sale.dart';

//services
import '../../../../../locator.dart';
import '../../../../../services/navigation.dart';

final NavigationService navigationService = locator<NavigationService>();

class RoutersPage extends StatefulWidget {
  const RoutersPage({super.key});

  @override
  State<RoutersPage> createState() => _RoutersPageState();
}

late SaleStepperBloc saleStepperBloc;

class _RoutersPageState extends State<RoutersPage> {
  final TextEditingController searchController = TextEditingController();

  final formatCurrency = NumberFormat.simpleCurrency();

  late SaleBloc saleBloc;

  @override
  void initState() {
    super.initState();
    saleBloc = BlocProvider.of<SaleBloc>(context);
    saleBloc.add(LoadRouters());
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
    return Stack(
      children: [
        SafeArea(
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
                        child: Icon(Icons.menu,
                            color: theme.colorScheme.onPrimaryContainer)),
                  ],
                ),
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
                              'Búsqueda por nombre rutero',
                              style:
                                  TextStyle(color: theme.colorScheme.tertiary),
                            )
                          ],
                        ),
                      ),
                    )),
                gapH4,
                BlocBuilder<SaleBloc, SaleState>(builder: (context, state) {
                  if (state is SaleInitial) {
                    return Expanded(
                      child: ListView.builder(
                          itemCount: state.routers.length,
                          itemBuilder: (context, index) {
                            return CardRouter(
                              codeRouter: state.routers[index].dayRouter!,
                              quantityClients: state
                                  .routers[index].quantityClient
                                  .toString(),
                              dayRouter:
                                  state.routers[index].nameDayRouter.toString(),
                              totalClients: state.routers[index].quantityClient,
                            );
                          }),
                    );
                  } else {
                    return const Center(child: Text('Cargando'));
                  }
                }),
              ],
            ),
          ),
        )
      ],
    );
  }
}
