import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

//blocs
import '../../../../blocs/sale/sale_bloc.dart';
import '../../../../blocs/sale_stepper/sale_stepper_bloc.dart';

//widgets
import '../../../../widgets/organisms/app_section.dart';

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
      child: Column(
        children: [
          ...state.sections != null
              ? state.sections!.map((e) => AppSection(
                  title: e.name!,
                  widgetItems: e.widgets ?? [],
                  tabController: null))
              : [],
        ],
      ),
    );
  }
}
