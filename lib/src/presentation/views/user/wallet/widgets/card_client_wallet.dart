import 'package:bexmovil/src/locator.dart';
import 'package:bexmovil/src/presentation/widgets/atomsbox.dart';
import 'package:bexmovil/src/services/navigation.dart';
import 'package:bexmovil/src/utils/constants/gaps.dart';
import 'package:bexmovil/src/utils/constants/strings.dart';
import 'package:bexmovil/src/utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../domain/models/client.dart';

class CardClientWallet extends StatefulWidget {
  final Function onTap;
  final Client client;

  const CardClientWallet(
      {super.key, required this.onTap, required this.client});

  @override
  State<CardClientWallet> createState() => _CardClientWalletState();
}



class _CardClientWalletState extends State<CardClientWallet> {

  bool value = false;
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(7),
      child: InkWell(
        onTap: widget.onTap,
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
                      Expanded(
                        child: AppText(
                            widget.client.rutero?.capitalizeString() ??
                                'Lunes primera semana',
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 15,
                            overflow: TextOverflow.ellipsis),
                      ),
                      Checkbox(
                        value: value,
                        onChanged: (newValue) {
                          setState(() {
                            value = newValue!;
                          });
                        },
                      )
                    ],
                  ),
                  gapH8,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText(
                          widget.client.name?.capitalizeString() ?? 'No name.',
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontSize: 14,
                          overflow: TextOverflow.ellipsis),
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
                              FontAwesomeIcons.circleExclamation,
                              color: theme.primaryColor,
                              size: 15,
                            ),
                          ),
                          gapW12,
                          AppText(
                              'Facturas vencidas: ${widget.client.total ?? 0}',
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
                    children: [
                      Opacity(
                        opacity: 0.5,
                        child: Icon(
                          FontAwesomeIcons.wallet,
                          color: theme.primaryColor,
                          size: 15,
                        ),
                      ),
                      gapW12,
                      AppText(
                          'Cartera: ${''.formatted(widget.client.wallet!.toDouble())}',
                          fontWeight: FontWeight.normal,
                          color: Colors.grey[800],
                          fontSize: 14,
                          overflow: TextOverflow.ellipsis)
                    ],
                  ),

                  /*   Row(
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
                  ), */
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
}
