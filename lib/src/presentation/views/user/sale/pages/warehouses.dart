import 'package:bexmovil/src/domain/models/arguments.dart';
import 'package:bexmovil/src/services/storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

//blocs
import '../../../../../utils/constants/screens.dart';
import '../../../../../utils/constants/strings.dart';
import '../../../../blocs/sale/sale_bloc.dart';
import '../../../../blocs/sale_stepper/sale_stepper_bloc.dart';

//features
import '../../../../widgets/organisms/app_section.dart';

//services
import '../../../../../locator.dart';
import '../../../../../services/navigation.dart';

final NavigationService navigationService = locator<NavigationService>();
final LocalStorageService storageService = locator<LocalStorageService>();

class WarehousesPage extends StatefulWidget {
  final WarehouseArgument arguments;
  const WarehousesPage({super.key, required this.arguments});

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
    saleBloc = BlocProvider.of<SaleBloc>(context);
    saleBloc.add(LoadWarehouses(
        navigation: 'go',
        codrouter: widget.arguments.codrouter,
        codcliente: widget.arguments.codcliente,
        codprecio: widget.arguments.codprecio,
        codbodega: widget.arguments.codbodega));
    super.initState();
  }

  @override
  void dispose() {
    saleBloc.add(LoadClients(widget.arguments.codrouter));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return BlocBuilder<SaleBloc, SaleState>(builder: (context, state) {
      if (state.status == SaleStatus.loading) {
        return const Center(
            child: CupertinoActivityIndicator(color: Colors.green));
      } else {
        return _buildBody(state, theme, context);
      }
    });
  }

  Widget _buildBody(SaleState state, ThemeData theme, context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ...state.sections != null
              ? state.sections!.map((e) => AppSection(
                  title: e.name!,
                  widgetItems: e.widgets ?? [],
                  tabController: null))
              : [],
          SizedBox(
            width: Screens.width(context),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  final user = storageService.getObject('user');

                  String? codbodega;
                  if (state.selectedWarehouse != null) {
                    codbodega = state.selectedWarehouse!.codbodega;
                  } else if (user?['codbodega'] != null) {
                    codbodega = user?['codbodega'];
                  } else {
                    codbodega = '001B1';
                  }

                  navigationService.goTo(AppRoutes.productsSale,
                      arguments: ProductArgument(
                          codcliente: widget.arguments.codcliente,
                          codbodega: codbodega!,
                          codprecio: widget.arguments.codprecio));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.primaryColor,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Text(
                  'Continuar',
                  style: theme.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w600, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
