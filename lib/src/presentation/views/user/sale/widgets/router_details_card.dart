import 'package:bexmovil/src/locator.dart';
import 'package:bexmovil/src/presentation/widgets/atoms/app_text.dart';
import 'package:bexmovil/src/services/navigation.dart';
import 'package:bexmovil/src/utils/constants/gaps.dart';
import 'package:bexmovil/src/utils/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final NavigationService _navigationService = locator<NavigationService>();

class RouterDetailsCard extends StatelessWidget {
  const RouterDetailsCard({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(7),
      child: InkWell(
        onTap: () {},
        child: Material(
          elevation: 1,
          child: Container(
         
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          AppText('Rutero',
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[700],
                              fontSize: 16,
                              overflow: TextOverflow.ellipsis),
                          AppText('Lunes primera semana',
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: 15,
                              overflow: TextOverflow.ellipsis)
                        ],
                      ),
                      Column(
                        children: [
                          AppText('0 %',
                              fontWeight: FontWeight.w500,
                              color: /* (effectiveness != null &&
                                      effectiveness!.toDouble() >= 70)
                                  ? Colors.green[300]
                                  : (effectiveness != null &&
                                          effectiveness!.toDouble() >= 50)
                                      ? Colors.yellow[400]
                                      :  */
                                  Colors.red[300],
                              fontSize: 14,
                              overflow: TextOverflow.ellipsis),
                          LinearProgressIndicator(
                            value: 8,
                            semanticsLabel: 'Linear progress indicator',
                          ),
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
                          AppText('Clientes totales: 0}',
                              fontWeight: FontWeight.normal,
                              color: Colors.grey[800],
                              fontSize: 16,
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
                          AppText('Clientes visitados: 0',
                              fontWeight: FontWeight.normal,
                              color: Colors.grey[800],
                              fontSize: 16,
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
                              color: Colors.green[300],
                              size: 15,
                            ),
                          ),
                          gapW12,
                          AppText('Prospectos:  0',
                              fontWeight: FontWeight.normal,
                              color: Colors.grey[800],
                              fontSize: 16,
                              overflow: TextOverflow.ellipsis)
                        ],
                      ),
                      Row(
                        children: [

                          AppText('Ventas totales: 0',
                              fontWeight: FontWeight.normal,
                              color: Colors.grey[800],
                              fontSize: 16,
                              overflow: TextOverflow.ellipsis)
                        ],
                      ),
                    ],
                  ),
                  gapH4,         
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
