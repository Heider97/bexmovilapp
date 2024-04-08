import 'package:bexmovil/src/domain/models/porduct.dart';
import 'package:bexmovil/src/locator.dart';
import 'package:bexmovil/src/presentation/widgets/atoms/app_icon_button.dart';
import 'package:bexmovil/src/presentation/widgets/user/custom_search_bar.dart';
import 'package:bexmovil/src/presentation/widgets/user/product_card.dart';
import 'package:bexmovil/src/services/navigation.dart';
import 'package:bexmovil/src/utils/constants/strings.dart';
import 'package:flutter/material.dart';

final NavigationService _navigationService = locator<NavigationService>();

class SelectProductsView extends StatefulWidget {
  const SelectProductsView({super.key});

  @override
  State<SelectProductsView> createState() => _SelectProductsViewState();
}

OriginLocation origin = OriginLocation(
    name: "Warehouse A", availableQuantity: 100, isSelected: true);

Product product = Product(
  lastSoldOn: DateTime.now(),
  lastQuantitySold: 10,
  code: "ABC123",
  name: "Product Name",
  sellingPrice: 20.5,
  discount: 0.1,
  availableUnits: 100,
  quantity: 5,
  originLocation: origin,
);

class _SelectProductsViewState extends State<SelectProductsView> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

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
                    onPressed: () {
                      _navigationService.goTo(
                        AppRoutes.filtersSale,
                      );
                    }),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: AppIconButton(
                    child: Icon(Icons.filter_alt_rounded,
                        color: theme.colorScheme.onPrimary),
                    onPressed: () {
                      _navigationService.goTo(
                        AppRoutes.filtersSale,
                      );
                    }),
              )
            ],
          ),
          Expanded(
            child: ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: ProductCard(
                      product: product,
                      refresh: () {},
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
