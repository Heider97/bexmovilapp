import 'package:bexmovil/src/domain/models/client.dart';
import 'package:bexmovil/src/presentation/blocs/sale/sale_bloc.dart';
import 'package:bexmovil/src/presentation/blocs/sale_stepper/sale_stepper_bloc.dart';
import 'package:bexmovil/src/utils/constants/gaps.dart';
import 'package:bexmovil/src/utils/constants/screens.dart';
import 'package:bexmovil/src/utils/constants/strings.dart';
import 'package:bexmovil/src/utils/extensions/date_time_extenstion.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClientCard extends StatefulWidget {
  final Client client;
  const ClientCard({super.key, required this.client});

  @override
  State<ClientCard> createState() => _ClientCardState();
}

class _ClientCardState extends State<ClientCard> {
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
      builder: (context, saleState) {
        return Material(
          shape: (saleState is SaleClienteSelected &&
                  saleState.client == widget.client)
              ? RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0), // Radio del borde
                  side: BorderSide(
                    color: theme.primaryColor, // Color del borde
                    width: 2.0,
                  ),
                )
              : null,
          elevation: 5,
          // borderRadius: BorderRadius.circular(20),
          child: SizedBox(
              width: Screens.width(context) * 0.9,
              //decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: InkWell(
                onTap: () {
                  saleBloc.add(SelectClient(client: widget.client));
                },
                child: Stack(
                  children: [
                    (widget.client.isBooked != null &&
                            widget.client.isBooked == true)
                        ? Positioned(
                            top: 10,
                            right: 10,
                            child: Container(
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.shade400,
                                        blurRadius: 2,
                                        spreadRadius: 1,
                                        offset: Offset(0, 2))
                                  ],
                                  color: Colors.green,
                                  borderRadius:
                                      BorderRadius.circular(Const.radius)),
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
                            widget.client.name ?? '',
                            style: theme.textTheme.displayLarge!.copyWith(
                                color: theme.primaryColor,
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
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
                                        '${widget.client.startTimeOfMeeting?.formatTime() ?? "No especifica"} - ${widget.client.endTimeOfMeeting?.formatTime() ?? "No especifica"}')
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
                                    text: widget.client.averageSales ??
                                        "No especifica")
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
                                    text: widget.client.salesEffectiveness ??
                                        "No especifica")
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
                                        '${widget.client.lastVisited?.formatTime() ?? "No especifica"} ')
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )),
        );
      },
    );
  }
}
