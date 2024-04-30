import 'package:bexmovil/src/presentation/views/user/sale/widgets/card_client.dart';
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
import '../../../../widgets/organisms/app_section.dart';
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
  TextEditingController textSaleController = TextEditingController();

  @override
  void initState() {
    super.initState();

    saleBloc = BlocProvider.of<SaleBloc>(context);
    saleBloc.add(LoadClients(widget.codeRouter));
  }

  @override
  void dispose() {
    saleBloc.add(LoadRouters());
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
                        saleBloc.add(SearchClientSale(valueToSearch: value));
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
              ],
            ),
          ),
          gapH8,
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
