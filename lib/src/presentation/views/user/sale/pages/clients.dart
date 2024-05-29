import 'package:bexmovil/src/presentation/blocs/maps_bloc/maps_bloc_bloc.dart';
import 'package:flutter/cupertino.dart' hide Router;
import 'package:flutter/material.dart' hide Router;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

//utils
import '../../../../../services/styled_dialog_controller.dart';
import '../../../../../utils/constants/strings.dart';
import '../../../../../utils/extensions/string_extension.dart';
import '../../../../../utils/constants/gaps.dart';

//domain
import '../../../../../domain/models/router.dart';

//blocs
import '../../../../blocs/sale/sale_bloc.dart';

//widgets and features
import '../../../../widgets/atoms/app_icon_button.dart';
import '../../../../widgets/atoms/app_text.dart';
import '../../../../widgets/user/custom_search_bar.dart';
import '../features/clients.dart';

//services
import '../../../../../locator.dart';
import '../../../../../services/navigation.dart';

final NavigationService navigationService = locator<NavigationService>();
final styledDialogController = locator<StyledDialogController>();

class ClientsPage extends StatefulWidget {
  final Router? router;
  const ClientsPage({super.key, this.router});

  @override
  State<ClientsPage> createState() => _ClientsPageState();
}

class _ClientsPageState extends State<ClientsPage> {
  final TextEditingController searchController = TextEditingController();

  final formatCurrency = NumberFormat.simpleCurrency();

  late SaleBloc saleBloc;
  TextEditingController textSaleController = TextEditingController();

  @override
  void initState() {
    saleBloc = BlocProvider.of<SaleBloc>(context);
    saleBloc.add(LoadClients(widget.router));
    super.initState();
  }

  @override
  void dispose() {
    saleBloc.add(LoadRouters());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SaleBloc, SaleState>(listener: (previous, current) {
      if (current.status == SaleStatus.warehouses) {
        styledDialogController.showDialogWithStyle(Status.warehouseAndPrices,
            closingFunction: () => Navigator.of(context).pop());
      }
    }, builder: (context, state) {
      if (state.status == SaleStatus.loading) {
        return const Center(
            child: CupertinoActivityIndicator(color: Colors.green));
      } else {
        return _buildBody(state, context);
      }
    });
  }

  Widget _buildBody(SaleState state, context) {
    ThemeData theme = Theme.of(context);
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: CustomSearchBar(
                      onChanged: (value) {
                        // saleBloc.add(SearchClient(valueToSearch: value));
                      },
                      colorBackground: theme.colorScheme.secondary,
                      prefixIcon: const Icon(Icons.search),
                      controller: textSaleController,
                      hintText: 'Buscar cliente'),
                ),
                gapW8,
                AppIconButton(
                    child: Icon(Icons.filter_alt_rounded,
                        color: theme.colorScheme.onPrimary),
                    onPressed: () => navigationService.goTo(
                          AppRoutes.filtersSale,
                        )),
                gapW8,
                AppIconButton(
                    child: Icon(Icons.map_rounded,
                        color: theme.colorScheme.onPrimary),
                    onPressed: () => navigationService.goTo(AppRoutes.saleMap,
                        arguments: state.router)),
              ],
            ),
          ),
          gapH8,
          if (state.router != null)
            Padding(
                padding: const EdgeInsets.only(left: 10),
                child: AppText(
                    'Rutero: ${state.router!.nameDayRouter!.capitalizeString()}',
                    fontSize: 14)),
          gapH8,
          const SaleClients()
        ],
      ),
    );
  }
}
