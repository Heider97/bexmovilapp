import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';


//blocs
import '../../../../blocs/sale/sale_bloc.dart';
import '../../../../blocs/sale_stepper/sale_stepper_bloc.dart';

//features
import '../../../../widgets/organisms/app_section.dart';


//services
import '../../../../../locator.dart';
import '../../../../../services/navigation.dart';

final NavigationService navigationService = locator<NavigationService>();

class WarehousesPage extends StatefulWidget {
  final String? codrouter;
  final String? codcliente;
  const WarehousesPage({super.key, this.codrouter, this.codcliente});

  @override
  State<WarehousesPage> createState() => _WarehousesPageState();
}

class _WarehousesPageState extends State<WarehousesPage> {
  final TextEditingController searchController = TextEditingController();

  final formatCurrency = NumberFormat.simpleCurrency();

  late SaleBloc saleBloc;
  TextEditingController textSaleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    saleBloc = BlocProvider.of<SaleBloc>(context);
    saleBloc.add(LoadWarehouses(widget.codcliente));
  }

  @override
  void dispose() {
    saleBloc.add(LoadClients(widget.codrouter));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SaleBloc, SaleState>(builder: (context, state) {
      if (state.status == SaleStatus.loading) {
        return const Center(
            child: CupertinoActivityIndicator(color: Colors.green));
      } else {
        return _buildBody(state, context);
      }
    });
  }

  Widget _buildBody(state, context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
