import 'package:bexmovil/src/domain/models/client.dart';
import 'package:bexmovil/src/presentation/widgets/atoms/show_map_direction_widget.dart';
import 'package:bexmovil/src/utils/constants/gaps.dart';
import 'package:bexmovil/src/utils/extensions/string_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../widgets/atoms/app_text.dart';

class CardClient extends StatefulWidget {
  final Client client;
  const CardClient({super.key, required this.client});

  @override
  State<CardClient> createState() => _CardClientState();
}

class _CardClientState extends State<CardClient> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Padding(
        padding: const EdgeInsets.all(7),
        child: InkWell(
            onTap: () {
              print('tapped');
            },
            child: Material(
                elevation: 1,
                child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(4)),
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  gapW12,
                                  Opacity(
                                    opacity: 0.8,
                                    child: AppText('Cliente',
                                        fontWeight: FontWeight.w500,
                                        color: theme.primaryColor,
                                        fontSize: 12,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                  AppText(
                                      widget.client.name?.capitalizeString() ??
                                          'No aplica',
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                      fontSize: 16,
                                      overflow: TextOverflow.ellipsis),
                                ],
                              ),
                              Column(
                                children: [
                                  AppText(
                                      '${widget.client.salesEffectiveness ?? '0'} %',
                                      fontWeight: FontWeight.w500,
                                      color: (widget.client
                                                      .salesEffectiveness !=
                                                  null &&
                                              double.parse(widget.client
                                                      .salesEffectiveness!) >=
                                                  70)
                                          ? Colors.green[300]
                                          : (widget.client.salesEffectiveness !=
                                                      null &&
                                                  double.parse(widget.client
                                                              .salesEffectiveness!)
                                                          .toDouble() >=
                                                      50)
                                              ? Colors.yellow[400]
                                              : Colors.red[300],
                                      fontSize: 14,
                                      overflow: TextOverflow.ellipsis),
                                  AppText('Servicio',
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
                              Expanded(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      /*  Opacity(
                                        opacity: 0.5,
                                        child: Icon(
                                          FontAwesomeIcons.peopleGroup,
                                          color: theme.primaryColor,
                                          size: 15,
                                        ),
                                      ),
                                      gapW12, */
                                      AppText('Dirección: ',
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
                                          fontSize: 16,
                                          overflow: TextOverflow.ellipsis),
                                      AppText('${widget.client.address ?? 0}',
                                          fontWeight: FontWeight.normal,
                                          color: Colors.grey[700],
                                          fontSize: 12,
                                          overflow: TextOverflow.ellipsis)
                                    ],
                                  ),
                                ),
                              ),
                              gapW8,
                              Row(
                                children: [
                                  AppText('Sucursal: ',
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                      fontSize: 16,
                                      overflow: TextOverflow.ellipsis),
                                  AppText('00',
                                      fontWeight: FontWeight.normal,
                                      color: Colors.grey[800],
                                      fontSize: 12,
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
                                  /*  Opacity(
                                    opacity: 0.5,
                                    child: Icon(
                                      FontAwesomeIcons.coins,
                                      color: theme.primaryColor,
                                      size: 15,
                                    ),
                                  ),
                                  gapW12, */
                                  AppText('Cartera: ',
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                      fontSize: 16,
                                      overflow: TextOverflow.ellipsis),
                                  AppText(
                                      widget.client.wallet != null
                                          ? ''.formattedCompact(
                                              widget.client.wallet.toString())
                                          : '0',
                                      fontWeight: FontWeight.normal,
                                      color: Colors.grey[800],
                                      fontSize: 12,
                                      overflow: TextOverflow.ellipsis)
                                ],
                              ),
                              Row(
                                children: [
                                  AppText('Ventas: ',
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                      fontSize: 16,
                                      overflow: TextOverflow.ellipsis),
                                  AppText('5M / Último mes',
                                      fontWeight: FontWeight.normal,
                                      color: Colors.grey[800],
                                      fontSize: 12,
                                      overflow: TextOverflow.ellipsis)
                                ],
                              ),
                            ],
                          ),
                          gapH4,
                          Row(
                            children: [
                              AppText('Cupo disponible: ',
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                  fontSize: 16,
                                  overflow: TextOverflow.ellipsis),
                              AppText('${widget.client.price}',
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey[800],
                                  fontSize: 12,
                                  overflow: TextOverflow.ellipsis)
                            ],
                          ),
                          gapH4,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: Center(
                                  child: InkWell(
                                    onTap: () async {
                                      return await MapsSheet.show(
                                          context: context,
                                          onMapTap: (map) {
                                            map.showDirections(
                                              destination: Coords(
                                                double.parse(
                                                    widget.client.latitude!),
                                                double.parse(
                                                    widget.client.longitude!),
                                              ),
                                              destinationTitle:
                                                  widget.client.businessName,
                                              originTitle: 'Origen',
                                              waypoints: null,
                                              directionsMode:
                                                  DirectionsMode.driving,
                                            );
                                          });
                                    },
                                    child: Material(
                                      elevation: 2,
                                      child: Container(
                                        width: 200,
                                        height: 50,
                                        /*   decoration: BoxDecoration(
                                          color: Colors.blue[200],
                                        ), */
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            AppText('Navegar',
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                fontSize: 14,
                                                overflow:
                                                    TextOverflow.ellipsis),
                                            Icon(
                                              FontAwesomeIcons.locationArrow,
                                              size: 20,
                                              color: Colors.blue[300],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  child: InkWell(
                                    onTap: () {
                                      launchUrl(
                                        Uri.parse(
                                            'tel://${widget.client.cellphone}'),
                                      );
                                    },
                                    child: Material(
                                      elevation: 2,
                                      child: Container(
                                        width: 200,
                                        height: 50,
                                        /*   decoration: BoxDecoration(
                                          color: Colors.blue[200],
                                        ), */
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            AppText(
                                                widget.client.cellphone ??
                                                    'No disponible',
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                fontSize: 14,
                                                overflow:
                                                    TextOverflow.ellipsis),
                                            Icon(
                                              FontAwesomeIcons.phone,
                                              size: 20,
                                              color: Colors.green[300],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          gapH12,
                          Material(
                            elevation: 2,
                            child: Opacity(
                              opacity:0.8,
                              child: Container(
                                width: double.infinity,
                                height: 50,
                                decoration:
                                    BoxDecoration(color: theme.primaryColor),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    AppText('Realizar Venta',
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 14,
                                        overflow: TextOverflow.ellipsis),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ]))))));
  }
}
