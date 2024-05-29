import 'package:bexmovil/src/utils/constants/strings.dart';
import 'package:bexmovil/src/utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';
//domain
import '../../../../../domain/models/client.dart';
//widgets
import '../../../../widgets/atomsbox.dart';
import 'detail_client.dart';

class CardClientSale extends StatefulWidget {
  final Client client;

  const CardClientSale({super.key, required this.client});

  @override
  State<CardClientSale> createState() => _CardClientSaleState();
}

class _CardClientSaleState extends State<CardClientSale> {
  Color _color = Colors.white; // Color inicial

  void _toggleColor(Color color) {
    setState(() {
      // Cambiar el color de la tarjeta
      _color = (_color == Colors.white) ? color : Colors.white;
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return AppCard.elevated(
      color: _color,
      surfaceTintColor: _color,
      elevation: 5,
      onLongPress: () {
        _toggleColor(theme.colorScheme.secondary);
      },
      onTap: () {
        (_color != Colors.white)
            ? _color = Colors.white
            : showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (c) => DetailClientSale(client: widget.client));

        setState(() {});
      },
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: AppListTile(
          color: _color,
          title: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: AppText(widget.client.name ?? "N/A",
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                  color: theme.primaryColor,
                  overflow: TextOverflow.ellipsis)),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Dirección: ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: Const.space12,
                        //   color: theme.primaryColor
                      ),
                    ),
                    TextSpan(
                      text: '${widget.client.address}',
                      style: const TextStyle(fontSize: Const.space12),
                    ),
                  ],
                ),
              ),
              Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Sucursal: ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: Const.space12,
                        // color: theme.primaryColor
                      ),
                    ),
                    TextSpan(
                      text: '${widget.client.branch}',
                      style: const TextStyle(fontSize: Const.space12),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text.rich(
                      TextSpan(
                        children: [
                          const TextSpan(
                            text: 'Cartera: ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: Const.space12,
                              //  color: theme.primaryColor
                            ),
                          ),
                          TextSpan(
                            text: widget.client.wallet != null
                                ? ''.formattedCompact(
                                    widget.client.wallet.toString())
                                : '20M',
                            style: const TextStyle(fontSize: Const.space12),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    child: Text.rich(
                      TextSpan(
                        children: [
                          const TextSpan(
                            text: 'Cupo disponible: ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: Const.space12,
                              //  color: theme.primaryColor
                            ),
                          ),
                          TextSpan(
                             text: ''.formattedCompact(widget.client.quota!.toString()),
                            style: const TextStyle(fontSize: Const.space12),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Ventas: ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: Const.space12,
                              //color: theme.primaryColor
                            ),
                          ),
                          TextSpan(
                            text: '1M / Último mes',
                            style: TextStyle(fontSize: Const.space12),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Servicio: ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: Const.space12,
                              //color: theme.primaryColor
                            ),
                          ),
                          TextSpan(
                            text: '90 % ',
                            style: TextStyle(fontSize: Const.space12),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
