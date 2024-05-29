import 'package:flutter/material.dart' hide Router;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//blocs
import '../../../../blocs/sale/sale_bloc.dart';

//utils
import '../../../../../utils/constants/gaps.dart';
import '../../../../../utils/constants/strings.dart';
import '../../../../../utils/extensions/string_extension.dart';

//domain
import '../../../../../domain/models/client.dart';
import '../../../../../domain/models/router.dart';

//widgets
import '../../../../widgets/atomsbox.dart';

class CardClientSale extends StatefulWidget {
  final Router? router;
  final Client client;
  final bool? activeSale;

  const CardClientSale(
      {super.key, required this.client, this.router, this.activeSale});

  @override
  State<CardClientSale> createState() => _CardClientSaleState();
}

class _CardClientSaleState extends State<CardClientSale> {
  late SaleBloc saleBloc;

  @override
  void initState() {
    saleBloc = BlocProvider.of<SaleBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppCard.filled(
      onTap: () {},
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: AppListTile(
          title: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: AppText(widget.client.name ?? "N/A",
                  fontWeight: FontWeight.normal,
                  fontSize: 12,
                  overflow: TextOverflow.ellipsis)),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text.rich(
                      TextSpan(
                        children: [
                          const TextSpan(
                            text: 'Dirección: ',
                            style: TextStyle(
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
                  ),
                  Flexible(
                    child: Text.rich(
                      TextSpan(
                        children: [
                          const TextSpan(
                            text: 'Sucursal: ',
                            style: TextStyle(
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
                  ),
                ],
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
                              fontSize: Const.space12,
                              //  color: theme.primaryColor
                            ),
                          ),
                          TextSpan(
                            text: ''.formattedCompact(
                                widget.client.quota!.toString()),
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
                              fontSize: Const.space12,
                              //color: theme.primaryColor
                            ),
                          ),
                          TextSpan(
                            text: '0%',
                            style: TextStyle(fontSize: Const.space12),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              gapH4,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Center(
                      child: InkWell(
                        onTap: widget.client.latitude != null &&
                                widget.client.longitude != null
                            ? () async {}
                            : null,
                        child: Material(
                          elevation: 2,
                          child: SizedBox(
                            width: 200,
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                widget.client.latitude != null &&
                                        widget.client.longitude != null
                                    ? AppText('Navegar',
                                        fontWeight: FontWeight.normal,
                                        color: Colors.grey[800],
                                        fontSize: 14,
                                        overflow: TextOverflow.ellipsis)
                                    : AppText('Georeferenciar',
                                        fontWeight: FontWeight.normal,
                                        color: Colors.grey[800],
                                        fontSize: 14,
                                        overflow: TextOverflow.ellipsis),
                                widget.client.latitude != null &&
                                        widget.client.longitude != null
                                    ? Icon(
                                        FontAwesomeIcons.locationArrow,
                                        size: 20,
                                        color: Colors.blue[300],
                                      )
                                    : Icon(
                                        FontAwesomeIcons.locationPin,
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
                  gapW8,
                  Expanded(
                    child: Center(
                      child: InkWell(
                        onTap: () {
                          // launchUrl(
                          //   Uri.parse('tel://${widget.client.cellphone}'),
                          // );
                        },
                        child: Material(
                          elevation: 2,
                          child: SizedBox(
                            width: 200,
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                AppText(
                                    widget.client.cellphone ?? 'No disponible',
                                    fontWeight: FontWeight.normal,
                                    color: Colors.grey[800],
                                    fontSize: 14,
                                    overflow: TextOverflow.ellipsis),
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
              AppTextButton(
                  child: AppText(
                      widget.client.typeClient == 'client'
                          ? 'Realizar Venta'
                          : 'Realizar Cotización',
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      overflow: TextOverflow.ellipsis),
                  onPressed: () {
                    final user = saleBloc.storageService.getObject('user');

                    String? codbodega;
                    if (user?['codbodega'] != null) {
                      codbodega = user?['codbodega'];
                    } else {
                      codbodega = '001B1';
                    }

                    saleBloc.add(LoadWarehousesAndPrices(
                      navigation: 'go',
                      router: widget.router,
                      client: widget.client,
                      codprecio: widget.client.codPrecio,
                      codbodega: codbodega,
                    ));
                  })
            ],
          ),
        ),
      ),
    );
  }
}
