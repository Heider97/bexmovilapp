import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//utils
import '../../../../../utils/constants/gaps.dart';
import '../../../../../utils/constants/strings.dart';
import '../../../../../utils/extensions/string_extension.dart';

//blocs

import '../../../../blocs/sale/sale_bloc.dart';

//utils
import '../../../../../utils/constants/screens.dart';

//widgets
import '../../../../widgets/atoms/atoms.dart';
import '../widgets/custom_card_product.dart';

class SaleProducts extends StatefulWidget {
  const SaleProducts({super.key});

  @override
  State<SaleProducts> createState() => _SaleProductsState();
}

class _SaleProductsState extends State<SaleProducts> {
  late SaleBloc saleBloc;
  int totalProducts = 0;

  @override
  void initState() {
    saleBloc = BlocProvider.of<SaleBloc>(context);
    saleBloc.add(GetDetailsShippingCart());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SaleBloc, SaleState>(
        // buildWhen: (previous, current) => previous.status != current.status || current.cant != previous.cant,
        builder: (context, state) {
      if (state.status == SaleStatus.products &&
          state.products != null &&
          state.products!.isNotEmpty) {
        return Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: Container(
                color: Colors.grey[100],
                child: ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: state.products?.length,
                    itemBuilder: (context, index) {
                      return CustomCardProduct(product: state.products![index]);
                    }),
              )),
              Material(
                  elevation: 10,
                  child: Container(
                    height: Screens.height(context) * 0.1,
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText(
                                'Productos: ${state.totalProductsShippingCart ?? 0}',
                              ),
                              AppText(
                                'Total: ${''.formatted(state.totalPriceShippingCart!)}',
                              )
                            ],
                          ),
                        ),
                        Row(children: [
                          AppTextButton(
                              onPressed: null, child: AppText('Vaciar')),
                          gapW20,
                          AppTextButton(
                              child: AppText('Ver Carrito'),
                              onPressed: () {
                                saleBloc.navigationService
                                    .goTo(AppRoutes.cartSale);
                              })
                        ])
                      ],
                    ),
                  ))
            ],
          ),
        );
      } else {
        return Center(child: AppText('No hay Productos'));
      }
    });
  }

  getProductsQuantity(state) async {
    // return await _databaseRepository.getTotalProductQuantity(
    //     state.router!.dayRouter!,
    //     state.priceSelected!.codprecio!,
    //     state.warehouseSelected!.codbodega!,
    //     state.client!.id.toString());
  }
}
