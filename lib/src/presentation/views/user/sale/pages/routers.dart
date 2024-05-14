import 'package:bexmovil/src/utils/constants/nums.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

//blocs
import '../../../../blocs/location/location_bloc.dart';
import '../../../../blocs/sale/sale_bloc.dart';

//utils
import '../../../../../utils/constants/gaps.dart';

//widgets and features
import '../../../../widgets/atoms/app_text.dart';
import '../features/routers.dart';

class RoutersPage extends StatefulWidget {
  const RoutersPage({super.key});

  @override
  State<RoutersPage> createState() => _RoutersPageState();
}

class _RoutersPageState extends State<RoutersPage> {
  final TextEditingController searchController = TextEditingController();
  final formatCurrency = NumberFormat.simpleCurrency();

  late SaleBloc saleBloc;
  late LocationBloc locationBloc;

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
      } else if (state.status == SaleStatus.routers) {
        return _buildBody(state, context);
      } else {
        return const SizedBox();
      }
    });
  }

  Widget _buildBody(state, context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.only(left: kDefaultPadding),
              child: AppText('Ruteros', fontSize: 16)),
          gapH8,
          const SaleRouters()
        ],
      ),
    );
  }
}
