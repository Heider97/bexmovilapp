
import 'package:bexmovil/src/domain/models/arguments.dart';
import 'package:bexmovil/src/domain/models/product.dart';
import 'package:bexmovil/src/locator.dart';
import 'package:bexmovil/src/presentation/blocs/sale/sale_bloc.dart';
import 'package:bexmovil/src/presentation/views/user/sale/widgets/product_card_row.dart';

import 'package:bexmovil/src/presentation/widgets/atoms/app_icon_button.dart';

import 'package:bexmovil/src/presentation/widgets/atomsbox.dart';
import 'package:bexmovil/src/presentation/widgets/user/custom_search_bar.dart';
import 'package:bexmovil/src/presentation/widgets/user/product_card.dart';
import 'package:bexmovil/src/services/navigation.dart';
import 'package:bexmovil/src/utils/constants/gaps.dart';

import 'package:bexmovil/src/utils/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final NavigationService _navigationService = locator<NavigationService>();

class SelectProductsView extends StatefulWidget {

  final ProductArgument arguments;

  const SelectProductsView({super.key, required this.arguments} );

  @override
  State<SelectProductsView> createState() => _SelectProductsViewState();
}

bool gridMode = false;
/* OriginLocation origin = OriginLocation(
    name: "Warehouse A", availableQuantity: 100, isSelected: true); */

/* Product product = Product(
  lastSoldOn: DateTime.now(),
  lastQuantitySold: 10,
  code: "ABC123",
  name: "Product Name",
  sellingPrice: 20.5,
  discount: 0.1,
  availableUnits: 100,
  quantity: 5,
  originLocation: origin,
); */

class _SelectProductsViewState extends State<SelectProductsView> {
  late SaleBloc saleBloc;

  @override
  void initState() {
    saleBloc = BlocProvider.of<SaleBloc>(context);
    saleBloc.add(LoadProducts(widget.arguments.codbodega, widget.arguments.codprecio));
    super.initState();
  }

  @override
  void dispose() {
    saleBloc.add(LoadWarehouses(widget.arguments.codcliente));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return BlocBuilder<SaleBloc, SaleState>(
      builder: (context, state) {
        return SafeArea(
          child: Column(
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
              (gridMode)
                  ? Expanded(
                      child: Container(
                        color: Colors.grey[200],
                        child: ListView.builder(
                            itemCount: 4,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 15.0),
                                child:Text('productCard') /* ProductCard(
                                  product: product,
                                  refresh: () {},
                                ), */
                              );
                            }),
                      ),
                    )
                  : Expanded(
                      child: Container(
                        color: Colors.grey[200],
                        child: ListView.builder(
                            itemCount: 2,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 15.0),
                                child: Text('productCardRow')/* ProductCardRow(
                                    firstProduct: product, secondProduct: null
                                    //TODO: que le ingresen dos clientes ambos opcionales
                                    /*    product: product,
                                  refresh: () {}, */
                                    ), */
                              );
                            }),
                      ),
                    ),
              Material(
                  elevation: 10,
                  child: Container(
                    height: 100,
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '4 productos',
                              style: theme.textTheme.titleLarge!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(),
                        Row(children: [
                          Text(
                            'Vaciar',
                            style: theme.textTheme.bodyMedium!
                                .copyWith(color: theme.primaryColor),
                          ),
                          gapW20,
                          InkWell(
                            onTap: () {
                              _navigationService.goTo(AppRoutes.shoppingCart);
                            },
                            child: Container(
                              height: 40,
                              child: Material(
                                color: theme.primaryColor,
                                borderRadius: BorderRadius.circular(10),
                                elevation: 5,
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15.0, right: 15),
                                    child: Text(
                                      'Ver Orden',
                                      style: theme.textTheme.bodyMedium!
                                          .copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ])
                      ],
                    ),
                  ))
            ],
          ),
        );
      },
    );
  }
}
