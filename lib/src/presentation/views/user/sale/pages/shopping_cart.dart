import 'package:bexmovil/src/domain/models/item_ammount.dart';
import 'package:bexmovil/src/locator.dart';
import 'package:bexmovil/src/presentation/blocs/sale/sale_bloc.dart';
import 'package:bexmovil/src/presentation/views/user/sale/pages/invoice_confirmation.dart';
import 'package:bexmovil/src/presentation/widgets/atoms/app_icon_button.dart';
import 'package:bexmovil/src/presentation/widgets/user/custom_search_bar.dart';
import 'package:bexmovil/src/presentation/widgets/user/product_ammount.dart';
import 'package:bexmovil/src/services/navigation.dart';
import 'package:bexmovil/src/utils/constants/gaps.dart';
import 'package:bexmovil/src/utils/constants/strings.dart';
import 'package:bexmovil/src/utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../widgets/atoms/app_text.dart';

final NavigationService _navigationService = locator<NavigationService>();

class ShoppingCartView extends StatefulWidget {
  const ShoppingCartView({super.key});

  @override
  State<ShoppingCartView> createState() => _ShoppingCartViewState();
}

class _ShoppingCartViewState extends State<ShoppingCartView> {
  late SaleBloc saleBloc;

  @override
  void initState() {
    saleBloc = BlocProvider.of<SaleBloc>(context);
    saleBloc.add(GetProductsShippingCart());
    super.initState();
  }

  @override
  void dispose() {
    saleBloc.add(DisposeShippingCart());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return BlocBuilder<SaleBloc, SaleState>(
      builder: (context, state) {
        if (state.cartProductInfo != null &&
            state.cartProductInfo!.products.isNotEmpty) {
          return SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      itemCount: state.cartProductInfo!.products.length,
                      itemBuilder: (context, index) {
                        return Padding(
                            padding:
                                const EdgeInsets.only(top: 15.0, bottom: 5),
                            child: ProductAmmount(
                                product:
                                    state.cartProductInfo!.products[index]));
                      }),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText.bodyMedium('Subtotal'),
                              AppText.titleLarge(''.formatted(
                                  state.totalPriceShippingCart ?? 0.0)),
                            ],
                          ),
                          const SizedBox(),
                          Row(children: [
                            AppText.bodyMedium('Vaciar'),
                            gapW20,
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          GettingStartedSignaturePad()),
                                );
                              },
                              child: SizedBox(
                                height: 40,
                                child: Material(
                                  color: theme.primaryColor,
                                  borderRadius: BorderRadius.circular(10),
                                  elevation: 5,
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15.0, right: 15),
                                      child: AppText.bodyMedium('Confirmar',
                                          color: Colors.white),
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
        } else {
          return Center(child: AppText('No hay productos en el carrito'));
        }
      },
    );
  }
}
