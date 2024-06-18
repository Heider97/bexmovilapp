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
import 'package:font_awesome_flutter/font_awesome_flutter.dart';



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

  OrderOption _currentOrder = OrderOption.codBarrasAsc;

  void _changeOrder() {
    setState(() {
      _currentOrder = OrderOption
          .values[(_currentOrder.index + 1) % OrderOption.values.length];

      saleBloc.add(OrderProductsBy(orderOption: _currentOrder));
    });
  }

  IconData _getIcon(OrderOption option) {
    switch (option) {
      case OrderOption.codBarrasAsc:
        return FontAwesomeIcons.arrowUp91;
      case OrderOption.codBarrasDesc:
        return FontAwesomeIcons.arrowDown19;
      case OrderOption.nombreAsc:
        return FontAwesomeIcons.arrowUpAZ;
      case OrderOption.nombreDesc:
        return FontAwesomeIcons.arrowDownAZ;
      case OrderOption.codProductoAsc:
        return FontAwesomeIcons.arrowUpAZ;
      case OrderOption.codProductoDesc:
        return FontAwesomeIcons.arrowDownAZ;
      default:
        return FontAwesomeIcons.arrowDownAZ;
    }
  }

  String _getText(OrderOption option) {
    switch (option) {
      case OrderOption.codBarrasAsc:
        return 'Cod Barras\n ASC';
      case OrderOption.codBarrasDesc:
        return 'Cod Barras\n DESC';
      case OrderOption.nombreAsc:
        return 'Nombre\n ASC';
      case OrderOption.nombreDesc:
        return 'Nombre\nDESC';
      case OrderOption.codProductoAsc:
        return 'Cod Producto\n ASC';
      case OrderOption.codProductoDesc:
        return 'Cod Producto\nDESC';
      default:
        return 'Código';
    }
  }

  @override
  void initState() {
    saleBloc = BlocProvider.of<SaleBloc>(context);
    saleBloc.add(GetDetailsShippingCart());
    
    //saleBloc.add(LoadProducts(null, null, null, null,
    //    widget.arguments.codbodega, widget.arguments.codprecio));

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
                  padding: const EdgeInsets.only(right: 8.0),
                  child: AppIconButton(
                      child: Column(
                        children: [
                          Icon(Icons.filter_alt_rounded,
                              color: theme.colorScheme.onPrimary),
                          Text(
                            'Filtro',
                            style: theme.textTheme.bodyMedium!.copyWith(
                                color: theme.colorScheme.onPrimary,
                                fontSize: 10),
                          )
                        ],
                      ),
                      onPressed: () {}),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: AppIconButton(
                    child: Column(
                      children: [
                        Icon(
                            (gridMode)
                                ? Icons.grid_view_rounded
                                : Icons.grid_view_outlined,
                            color: theme.colorScheme.onPrimary),
                        Text(
                          'Modo',
                          style: theme.textTheme.bodyMedium!.copyWith(
                              color: theme.colorScheme.onPrimary, fontSize: 10),
                        )
                      ],
                    ),
                    onPressed: () {
                      int currentIndex = state.grids!.indexOf(state.grid!);
                      int nextIndex = (currentIndex + 1) % state.grids!.length;
                      var grid = state.grids![nextIndex];

                      context.read<SaleBloc>().add(GridModeChange(grid: grid));
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: AppIconButton(
                    onPressed: _changeOrder,
                    child: Column(
                      children: [
                        Icon(_getIcon(_currentOrder),
                            color: theme.colorScheme.onPrimary),
                        Text(
                          _getText(_currentOrder),
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyMedium!.copyWith(
                            color: theme.colorScheme.onPrimary,
                            fontSize: 10,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            gapH8,
            SaleProducts(
                codprecio: widget.arguments.codprecio,
                codbodega: widget.arguments.codbodega)
          ],
        );
      },
    );
  }
}
