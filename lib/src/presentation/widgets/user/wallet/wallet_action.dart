import 'package:bexmovil/src/locator.dart';
import 'package:bexmovil/src/services/navigation.dart';
import 'package:bexmovil/src/utils/constants/strings.dart';
import 'package:flutter/material.dart';

final NavigationService _navigationService = locator<NavigationService>();

class WalletAction extends StatefulWidget {
  final int index;
  const WalletAction({super.key, required this.index});

  @override
  State<WalletAction> createState() => _WalletActionState();
}

class _WalletActionState extends State<WalletAction> {
  CustomWalletCard card = CustomWalletCard(name: 'name', image: Assets.cash);

  @override
  void initState() {
    switch (widget.index) {
      case 0:
        card =
            CustomWalletCard(name: 'Efectivo', image: Assets.cash, ammount: 0);
        break;
      case 1:
        card =
            CustomWalletCard(name: 'Cheque', image: Assets.check, ammount: 1);
        break;
      case 2:
        card = CustomWalletCard(
            name: 'Consignación', image: Assets.consignment, ammount: 2);
        break;
      case 3:
        card = CustomWalletCard(
            name: 'Nota Credito', image: Assets.creditNote, ammount: 3);
        break;

      default:
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          _navigationService.goTo(AppRoutes.walletDetailsScreen);
        },
        child: Card(
          color: Colors.white,
          elevation: 2,
          surfaceTintColor: Colors.white,
          child: Row(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                card.image,
                width: 100,
                height: 70,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    card.name,
                    style: theme.textTheme.bodyMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text('\$ ${card.ammount.toString()}',
                      style: theme.textTheme.bodyMedium!
                          .copyWith(color: Colors.grey[500])),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}

class CustomWalletCard {
  final String name;
  double? ammount;
  final String image;
  CustomWalletCard({required this.name, required this.image, this.ammount});
}
