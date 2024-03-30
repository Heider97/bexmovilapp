import 'package:bexmovil/src/locator.dart';
import 'package:bexmovil/src/presentation/widgets/atomsbox.dart';
import 'package:bexmovil/src/services/navigation.dart';
import 'package:bexmovil/src/utils/constants/gaps.dart';
import 'package:bexmovil/src/utils/constants/strings.dart';
import 'package:bexmovil/src/utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final NavigationService _navigationService = locator<NavigationService>();

class CardRouter extends StatelessWidget {
  final String quantityClients;
  final String codeRouter;
  final String dayRouter;
  final int? totalClients;
  final int? totalProspects;
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
      this.totalProspects,
      this.visited,
      this.withSale,
      this.coverage,
      this.effectiveness});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(7),
      child: InkWell(
        onTap: () => _navigationService.goTo(AppRoutes.clientsSale,
            arguments: codeRouter),
        child: Material(
          elevation: 1,
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText(dayRouter.capitalizeString(),
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontSize: 14,
                          overflow: TextOverflow.ellipsis),
                      Column(
                        children: [
                          AppText('${effectiveness ?? '0'} %',
                              fontWeight: FontWeight.w500,
                              color: (effectiveness != null &&
                                      effectiveness!.toDouble() >= 70)
                                  ? Colors.green[300]
                                  : (effectiveness != null &&
                                          effectiveness!.toDouble() >= 50)
                                      ? Colors.yellow[400]
                                      : Colors.red[300],
                              fontSize: 12,
                              overflow: TextOverflow.ellipsis),
                          AppText('Efectividad',
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[800],
                              fontSize: 12,
                              overflow: TextOverflow.ellipsis)
                        ],
                      )
                    ],
                  ),
                  gapH8,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Opacity(
                            opacity: 0.5,
                            child: Icon(
                              FontAwesomeIcons.peopleGroup,
                              color: theme.primaryColor,
                              size: 15,
                            ),
                          ),
                          gapW12,
                          AppText('Clientes totales: ${totalClients ?? 0}',
                              fontWeight: FontWeight.normal,
                              color: Colors.grey[800],
                              fontSize: 14,
                              overflow: TextOverflow.ellipsis)
                        ],
                      ),
                      Row(
                        children: [
                          /*      Opacity(
                            opacity: 0.5,
                            child: Icon(
                              FontAwesomeIcons.usersBetweenLines,
                              color: theme.primaryColor,
                              size: 15,
                            ),
                          ), */
                          gapW12,
                          AppText('Clientes visitados: ${visited ?? '0'}',
                              fontWeight: FontWeight.normal,
                              color: Colors.grey[800],
                              fontSize: 14,
                              overflow: TextOverflow.ellipsis)
                        ],
                      ),
                    ],
                  ),
                  gapH4,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Opacity(
                            opacity: 0.5,
                            child: Icon(
                              FontAwesomeIcons.peopleGroup,
                              color: Colors.blue[300],
                              size: 15,
                            ),
                          ),
                          gapW12,
                          AppText('Prospectos: ${totalProspects ?? 0}',
                              fontWeight: FontWeight.normal,
                              color: Colors.grey[800],
                              fontSize: 14,
                              overflow: TextOverflow.ellipsis)
                        ],
                      ),
                      Row(
                        children: [
/*                           Opacity(
                            opacity: 0.5,
                            child: Icon(
                              FontAwesomeIcons.cashRegister,
                              color: theme.primaryColor,
                              size: 15,
                            ),
                          ),
                          gapW12, */
                          AppText('Ventas totales: ${withSale ?? 0}',
                              fontWeight: FontWeight.normal,
                              color: Colors.grey[800],
                              fontSize: 14,
                              overflow: TextOverflow.ellipsis)
                        ],
                      ),
                    ],
                  ),
                  gapH4,
                  /* cardButtons(
                      FontAwesomeIcons.cashRegister, "${withSale ?? '0'}", context),
                  cardButtons(FontAwesomeIcons.usersBetweenLines,
                      "${visited ?? '0'}", context),
                  cardButtons(FontAwesomeIcons.chartSimple,
                      "${effectiveness ?? '0'}%", context), */
                ],
              ),
            ),
          ),
        ),
      ),
    );

    /*  AppCard.filled(
      onTap: () =>
          _navigationService.goTo(AppRoutes.clientsSale, arguments: codeRouter),
     /*  shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.circular(10),
      ), */
      color: Colors.red,
      surfaceTintColor: Colors.red,
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 6),
      child: Text(dayRouter)/* AppListTile(
          title: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: AppText(dayRouter,
                  fontWeight: FontWeight.normal,
                  overflow: TextOverflow.ellipsis)),
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
                  "${effectiveness ?? '0'}%", context),
            ],
          )) */,
    ); */
  }

/*   Widget cardButtons(IconData icon, String text, BuildContext context) {
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
          child: AppText(text, fontSize: 14.0),
        )
      ],
    );
  } */
}
