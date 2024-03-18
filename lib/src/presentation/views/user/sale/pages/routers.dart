import 'package:bexmovil/src/presentation/widgets/atomsbox.dart';
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

//widgets
import '../../../../widgets/atoms/app_back_button.dart';
import '../../../../widgets/atoms/app_icon_button.dart';
import '../../../../widgets/organisms/app_section.dart';
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
    return Stack(
      children: [
        BlocBuilder<SaleBloc, SaleState>(builder: (context, state) {
          if (state.status == SaleStatus.loading) {
            return const Center(
                child: CupertinoActivityIndicator(color: Colors.green));
          } else {
            return _buildBody(state, context);
          }
        }),
      ],
    );
  }

  Widget _buildBody(state, context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(Const.space15),
        child: Column(
          children: [
            ...state.sections != null
                ? state.sections!.map((e) => AppSection(
                    title: e.name!,
                    type: e.type,
                    componentItems: e.components ?? [],
                    tabController: null))
                : [],
          ],
        ),
      ),
    );
  }
}


