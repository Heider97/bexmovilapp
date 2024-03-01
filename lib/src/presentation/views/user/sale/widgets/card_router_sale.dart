import 'package:bexmovil/src/locator.dart';
import 'package:bexmovil/src/presentation/widgets/atomsbox.dart';
import 'package:bexmovil/src/services/navigation.dart';
import 'package:bexmovil/src/utils/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final NavigationService _navigationService = locator<NavigationService>();

class CardRouter extends StatelessWidget {
  final String quantityClients;
  final String codeRouter;
  final String dayRouter;
  final int? totalClients;
  final int? visited;
  final int? withSale;
  final int? coverage;
  final int? effectiveness;

  const CardRouter(
      {super.key,
      required this.codeRouter,
      required this.quantityClients,
      required this.dayRouter,
      this.totalClients,
      this.visited,
      this.withSale,
      this.coverage,
      this.effectiveness});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 6),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 1,
            ),
          ],
        ),
        child: AppListTile(
          onTap: () => _navigationService.goTo(AppRoutes.clientsSale,
              arguments: codeRouter),
          title: AppText(dayRouter),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              cardButtons(FontAwesomeIcons.peopleGroup,
                  "${totalClients ?? '0'}", context),
              cardButtons(
                  FontAwesomeIcons.cashRegister, "${withSale ?? '0'}", context),
              cardButtons(FontAwesomeIcons.usersBetweenLines,
                  "${visited ?? '0'}", context),
              cardButtons(FontAwesomeIcons.chartSimple,
                  "${effectiveness ?? '0'} %", context),
            ],
          ),
        ),
      ),
    );
  }

  Widget cardButtons(IconData icon, String text, BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Row(
      children: [
        Icon(
          icon,
          size: 18.0,
          color: theme.colorScheme.primary,
        ),
        Container(
          margin: const EdgeInsets.all(6.0),
          child: Text(
            text,
            style: const TextStyle(color: Colors.black45, fontSize: 14.0),
          ),
        )
      ],
    );
  }
}
