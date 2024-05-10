import 'package:bexmovil/src/locator.dart';
import 'package:bexmovil/src/presentation/views/user/sale/widgets/custom_card_product.dart';
import 'package:bexmovil/src/presentation/views/user/sale/widgets/custom_card_product_back.dart';
import 'package:bexmovil/src/services/navigation.dart';
import 'package:bexmovil/src/utils/constants/gaps.dart';
import 'package:bexmovil/src/utils/constants/screens.dart';
import 'package:bexmovil/src/utils/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';

//domain
import '../../../../../domain/models/product.dart';

//blocs
import '../../../../blocs/sale/sale_bloc.dart';

//widgets
import '../../../../widgets/atoms/app_text.dart';
import '../../../../widgets/user/product_card.dart';

final NavigationService _navigationService = locator<NavigationService>();

class SaleProducts extends StatefulWidget {
  final List<Product>? products;

  const SaleProducts({super.key, this.products});

  @override
  State<SaleProducts> createState() => _SaleProductsState();
}

class _SaleProductsState extends State<SaleProducts> {
  late SaleBloc saleBloc;

  @override
  void initState() {
    saleBloc = BlocProvider.of<SaleBloc>(context);
    super.initState();
  }

  @override
  void dispose() {
    saleBloc.add(ResetStatus(status: SaleStatus.clients));

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return BlocBuilder<SaleBloc, SaleState>(builder: (context, state) {
      if (state.status == SaleStatus.products &&
          widget.products != null &&
          widget.products!.isNotEmpty) {
        return Column(
          children: [
            Container(
              color: Colors.grey[200]!,
              height: Screens.height(context) * 0.77,
              child: ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: widget.products?.length,
                  itemBuilder: (context, index) {
                    List<Widget> carouselItems = [
                      CustomCardProduct(product: widget.products![index]),
                      CustomCardProductBack(product: widget.products![index])
                    ];

                    return CarouselSlider(
                      options: CarouselOptions(
                        height: MediaQuery.of(context).size.height * 0.22,
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

                    /*  return ProductCard(
                      product: widget.products![index],
                      refresh: () {},
                    ); */
                  }),
            ),
          /*   Material(
                elevation: 10,
                child: Container(
                  height: 80,
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
                            ' 0 productos',
                            style: theme.textTheme.titleLarge!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
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
                                  child: Text(
                                    'Ver Carrito',
                                    style: theme.textTheme.bodyMedium!.copyWith(
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
                )) */
          ],
        );
      } else {
        return Center(child: AppText('No hay Productos'));
      }
    });
  }
}
