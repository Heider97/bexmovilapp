import 'package:bexmovil/src/domain/repositories/database_repository.dart';
import 'package:bexmovil/src/utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';

//blocs
import '../../../../../utils/constants/gaps.dart';
import '../../../../../utils/constants/strings.dart';
import '../../../../blocs/sale/sale_bloc.dart';

//utils
import '../../../../../utils/constants/screens.dart';

//widgets
import '../../../../widgets/atoms/app_text.dart';
import '../../../../widgets/atoms/app_text_button.dart';
import '../../../../widgets/user/product_card.dart';
import '../widgets/custom_card_product.dart';
import '../widgets/custom_card_product_back.dart';

//services
import '../../../../../locator.dart';
import '../../../../../services/navigation.dart';

final NavigationService _navigationService = locator<NavigationService>();
final DatabaseRepository _databaseRepository = locator<DatabaseRepository>();

class SaleProducts extends StatefulWidget {
  const SaleProducts({super.key});

  @override
  State<SaleProducts> createState() => _SaleProductsState();
}

class _SaleProductsState extends State<SaleProducts> {
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
                              FutureBuilder(
                                future:
                                    _databaseRepository.getTotalProductQuantity(
                                        state.router!.dayRouter!,
                                        state.priceSelected!.codprecio!,
                                        state.warehouseSelected!.codbodega!,
                                        state.client!.id.toString()),
                                builder: (context, snapshot) {
                                  return (snapshot.hasData)
                                      ? AppText(
                                          'Productos: ${snapshot.data ?? 0.0}',
                                        )
                                      : AppText(
                                          'Productos: 0',
                                        );
                                },
                              ),
                            ],
                          ),
                        ),
                        Row(children: [
                          AppText('Vaciar'),
                          gapW20,
                          SizedBox(
                              height: 40,
                              child: AppTextButton(
                                  child: AppText('Ver Carrito'),
                                  onPressed: () {
                                    _navigationService.goTo(AppRoutes.cartSale);
                                  })),
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
}
