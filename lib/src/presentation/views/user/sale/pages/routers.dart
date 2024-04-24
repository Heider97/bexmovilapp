import 'package:bexmovil/src/presentation/blocs/location/location_bloc.dart';
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
late LocationBloc locationBloc;

class _RoutersPageState extends State<RoutersPage> {
  final TextEditingController searchController = TextEditingController();

  final formatCurrency = NumberFormat.simpleCurrency();

  late SaleBloc saleBloc;

  @override
  void initState() {
    super.initState();
    saleBloc = BlocProvider.of<SaleBloc>(context);
    locationBloc = BlocProvider.of<LocationBloc>(context);

    saleBloc.add(LoadRouters());
    locationBloc.startFollowingUser();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SaleBloc, SaleState>(builder: (context, state) {
      if (state.status == SaleStatus.loading) {
        return const Center(
            child: CupertinoActivityIndicator(color: Colors.green));
      } else if (state.status == SaleStatus.showRouters) {
        return _buildBody(state, context);
      } else {
        return Container();
      }
    });
  }

  Widget _buildBody(state, context) {
    return Column(
      children: [
        ...state.sections != null
            ? state.sections!.map((e) => AppSection(
                title: e.name!,
                widgetItems: e.widgets ?? [],
                tabController: null))
            : [],
      ],
    );
  }
}
