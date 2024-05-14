import 'package:flutter/material.dart';
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

class SaleProducts extends StatefulWidget {
  const SaleProducts({super.key});

  @override
  State<SaleProducts> createState() => _SaleProductsState();
}

class _SaleProductsState extends State<SaleProducts> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return BlocBuilder<SaleBloc, SaleState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          if (state.status == SaleStatus.products &&
              state.products != null &&
              state.products!.isNotEmpty) {
            return Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemCount: state.products?.length,
                          itemBuilder: (context, index) {
                            List<Widget> carouselItems = [
                              CustomCardProduct(
                                  product: state.products![index]),
                              CustomCardProductBack(
                                  product: state.products![index])
                            ];
                            return CarouselSlider(
                              options: CarouselOptions(
                                height:
                                    MediaQuery.of(context).size.height * 0.22,
                                enableInfiniteScroll: false,
                                autoPlayInterval: const Duration(seconds: 4),
                                aspectRatio: 2,
                                enlargeCenterPage: false,
                                scrollDirection: Axis.horizontal,
                                autoPlay: false,
                                viewportFraction: 1,
                              ),
                              items: carouselItems.map((item) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return item;
                                  },
                                );
                              }).toList(),
                            );
                          })),
                  Material(
                      elevation: 10,
                      child: Container(
                        height: 60,
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                AppText(
                                  ' 0 Productos',
                                ),
                              ],
                            ),
                            Row(children: [
                              AppText('Vaciar'),
                              gapW20,
                              SizedBox(
                                  height: 40,
                                  child: AppTextButton(
                                      child: AppText('Ver Carrito'),
                                      onPressed: () {
                                        _navigationService
                                            .goTo(AppRoutes.cartSale);
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
