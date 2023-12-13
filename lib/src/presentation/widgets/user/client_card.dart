/* import 'package:bexmovil/src/domain/models/client.dart';
import 'package:bexmovil/src/utils/constants/gaps.dart';
import 'package:bexmovil/src/utils/constants/screens.dart';
import 'package:bexmovil/src/utils/constants/strings.dart';

import 'package:flutter/material.dart';

class ClientCard extends StatelessWidget {
  final Client client;
  const ClientCard({super.key, required this.client});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(20),
      child: SizedBox(
          width: Screens.width(context) * 0.9,
          //decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child: Stack(
            children: [
              (client.isBooked != null && client.isBooked == true)
                  ? Positioned(
                      top: 10,
                      right: 10,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(Const.radius)),
                        width: 100,
                        height: 30,
                        child: Center(
                            child: (Text(
                          'Agenda',
                          style: theme.textTheme.bodyMedium!
                              .copyWith(color: theme.cardColor),
                        ))),
                      ))
                  : Container(),
              Padding(
                padding: const EdgeInsets.all(Const.space15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      client.name,
                      style: theme.textTheme.displayLarge!
                          .copyWith(color: theme.primaryColor),
                    ),
                    gapH16,
                    Text.rich(
                      TextSpan(
                        children: <TextSpan>[
                          const TextSpan(
                            text: 'Hora de Encuentro: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                              text:
                                  '${client.startTimeOfMeeting?.formatTime() ?? "No especifica"} - ${client.endTimeOfMeeting?.formatTime() ?? "No especifica"}')
                        ],
                      ),
                    ),
                    Text.rich(
                      TextSpan(
                        children: <TextSpan>[
                          const TextSpan(
                            text: 'Promedio de ventas: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                              text: '${client.averageSales ?? "No especifica"}')
                        ],
                      ),
                    ),
                    Text.rich(
                      TextSpan(
                        children: <TextSpan>[
                          const TextSpan(
                            text: 'Efectividad: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                              text:
                                  '${client.salesEffectiveness ?? "No especifica"}')
                        ],
                      ),
                    ),
                    Text.rich(
                      TextSpan(
                        children: <TextSpan>[
                          const TextSpan(
                            text: 'Visitado por última vez: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                              text:
                                  '${client.lastVisited?.formatTime() ?? "No especifica"} ')
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
 */