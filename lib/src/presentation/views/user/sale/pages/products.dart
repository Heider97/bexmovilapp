import 'package:bexmovil/src/domain/models/arguments.dart';
import 'package:bexmovil/src/locator.dart';
import 'package:bexmovil/src/presentation/blocs/sale/sale_bloc.dart';
import 'package:bexmovil/src/presentation/views/user/sale/features/products.dart';

import 'package:bexmovil/src/presentation/widgets/atoms/app_icon_button.dart';

import 'package:bexmovil/src/presentation/widgets/atomsbox.dart';
import 'package:bexmovil/src/presentation/widgets/user/custom_search_bar.dart';
import 'package:bexmovil/src/services/navigation.dart';
import 'package:bexmovil/src/utils/constants/gaps.dart';

import 'package:bexmovil/src/utils/constants/strings.dart';
import 'package:bexmovil/src/utils/extensions/string_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:googleapis/transcoder/v1.dart';

import '../../../../widgets/organisms/app_section.dart';

final NavigationService _navigationService = locator<NavigationService>();

class ProductsView extends StatefulWidget {
  final ProductArgument arguments;

  const ProductsView({super.key, required this.arguments});

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  late SaleBloc saleBloc;
  bool gridMode = false;

  @override
  void initState() {
    saleBloc = BlocProvider.of<SaleBloc>(context);
    //TODO: [Heider Zapa] resolve
    saleBloc.add(LoadProducts(null, null, null, null,
        widget.arguments.codbodega, widget.arguments.codprecio));
    super.initState();
  }

  @override
  void dispose() {
    saleBloc.add(LoadWarehousesAndPrices(
        navigation: 'back',
        client: widget.arguments.client,
        codprecio: widget.arguments.codprecio,
        codbodega: widget.arguments.codbodega));
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

  Widget _buildBody(state, ThemeData theme, context) {
    return BlocBuilder<SaleBloc, SaleState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: CustomSearchBar(
                        onChanged: (value) {},
                        colorBackground: theme.colorScheme.secondary,
                        prefixIcon: const Icon(Icons.search),
                        controller: TextEditingController(),
                        hintText: 'Buscar producto',
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AppIconButton(
                      child: Icon(Icons.filter_alt_rounded,
                          color: theme.colorScheme.onPrimary),
                      onPressed: () {}),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: AppIconButton(
                    child: Icon(
                        (gridMode)
                            ? Icons.grid_view_rounded
                            : Icons.grid_view_outlined,
                        color: theme.colorScheme.onPrimary),
                    onPressed: () {
                      setState(() {
                        gridMode = !gridMode;
                      });
                      //TODO: disable grid view. change icon too
                    },
                  ),
                )
              ],
            ),
            gapH8,
            Padding(
                padding: const EdgeInsets.only(left: 10),
                child: AppText(
                  'Rutero: ${state.router!.nameDayRouter!.capitalizeString()}',
                  fontWeight: FontWeight.normal,
                  color: Colors.grey[800],
                  fontSize: 14,
                )),
            Padding(
                padding: const EdgeInsets.only(left: 10),
                child: AppText(
                  'Cliente: ${state.client!.name!.capitalizeString()}',
                  fontWeight: FontWeight.normal,
                  color: Colors.grey[800],
                  fontSize: 14,
                )),
            gapH8,
            const SaleProducts()
          ],
        );
      },
    );
  }
}
