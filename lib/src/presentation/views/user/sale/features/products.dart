import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';

//blocs
import '../../../../blocs/sale/sale_bloc.dart';

//utils
import '../../../../../utils/constants/screens.dart';

//widgets
import '../../../../widgets/atoms/app_text.dart';
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
    return BlocBuilder<SaleBloc, SaleState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          print(state.status);

          if (state.status == SaleStatus.products &&
              state.products != null &&
              state.products!.isNotEmpty) {
            return Column(
              children: [
                Container(
                  color: Colors.grey[200]!,
                  height: Screens.height(context) * 0.77,
                  child: ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: state.products?.length,
                      itemBuilder: (context, index) {
                        List<Widget> carouselItems = [
                          CustomCardProduct(product: state.products![index]),
                          CustomCardProductBack(product: state.products![index])
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
