import 'package:bexmovil/src/domain/models/arguments.dart';
import 'package:bexmovil/src/presentation/blocs/sale/sale_bloc.dart';
import 'package:bexmovil/src/presentation/views/user/sale/features/products.dart';

import 'package:bexmovil/src/presentation/widgets/atomsbox.dart';
import 'package:bexmovil/src/presentation/widgets/user/custom_search_bar.dart';
import 'package:bexmovil/src/utils/constants/gaps.dart';

import 'package:bexmovil/src/utils/extensions/string_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsView extends StatefulWidget {
  final ProductArgument arguments;

  const ProductsView({super.key, required this.arguments});

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  late SaleBloc saleBloc;

  final TextEditingController textEditingController = TextEditingController();
  bool gridMode = false;

  @override
  void initState() {
    saleBloc = BlocProvider.of<SaleBloc>(context);
    saleBloc.add(GetDetailsShippingCart());
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
            Row(
              children: [
                Expanded(
                  child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: CustomSearchBar(
                        onChanged: (value) {
                          saleBloc.add(SearchProduct(value));
                        },
                        colorBackground: theme.colorScheme.secondary,
                        prefixIcon: const Icon(Icons.search),
                        controller: textEditingController,
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
                    },
                  ),
                )
              ],
            ),
            gapH8,
            SaleProducts(codprecio: widget.arguments.codprecio, codbodega: widget.arguments.codbodega)
          ],
        );
      },
    );
  }
}
