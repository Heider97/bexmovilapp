import 'package:bexmovil/src/domain/models/item_ammount.dart';
import 'package:bexmovil/src/locator.dart';
import 'package:bexmovil/src/presentation/blocs/sale/sale_bloc.dart';
import 'package:bexmovil/src/presentation/widgets/atoms/app_icon_button.dart';
import 'package:bexmovil/src/presentation/widgets/user/custom_search_bar.dart';
import 'package:bexmovil/src/presentation/widgets/user/product_ammount.dart';
import 'package:bexmovil/src/services/navigation.dart';
import 'package:bexmovil/src/utils/constants/gaps.dart';
import 'package:bexmovil/src/utils/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final NavigationService _navigationService = locator<NavigationService>();

class ShoppingCartView extends StatefulWidget {
  const ShoppingCartView({super.key});

  @override
  State<ShoppingCartView> createState() => _ShoppingCartViewState();
}

class _ShoppingCartViewState extends State<ShoppingCartView> {
  @override
  late SaleBloc saleBloc;
  @override
  void initState() {
    saleBloc = BlocProvider.of<SaleBloc>(context);
    super.initState();
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
                  ),Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Const.padding, vertical: 5),
                      child: AppIconButton(
                          onPressed: () => Scaffold.of(context).openDrawer(),
                          child: Icon(
                            Icons.menu,
                            color: theme.colorScheme.onPrimary,
                          )),
                    )
                ],
              ),
              Expanded(
                child: Container(
                  color: Colors.grey[200],
                  child: ListView.builder(
                      itemCount: 8,
                      itemBuilder: (context, index) {
                        return Padding(
                            padding: EdgeInsets.only(top: 15.0),
                            child: ProductAmmount(
                              product: ItemAmount(
                                  image: 'assets/images/menu.png',
                                  title:
                                      'Cerdo Levante 1 Naranga Mega Pro 35% Para Vacas',
                                  weight: '40 Kg',
                                  price: 541545549,
                                  discount: '17%',
                                  origin: 'origin'),
                            ));
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Subtotal',
                              style: theme.textTheme.bodyMedium!
                            ),
                            Text(
                              '\$ 592.800.000',
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
                            onTap: () {},
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
                                      'Confirmar',
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
