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
    final size = MediaQuery.of(context).size;
    return AppCard.filled(
      onTap: () {},
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
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
                  AppElevatedButton(
                    minimumSize: Size(size.width / 2.3, 40),
                    onPressed: widget.client.latitude != null &&
                            widget.client.longitude != null
                        ? () async {}
                        : null,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppText(
                            widget.client.latitude != null &&
                                    widget.client.longitude != null
                                ? 'Navegar'
                                : 'Georeferenciar',
                            fontWeight: FontWeight.normal,
                            color: Colors.grey[800],
                            fontSize: 12,
                            overflow: TextOverflow.ellipsis),
                        Icon(
                          widget.client.latitude != null &&
                                  widget.client.longitude != null
                              ? FontAwesomeIcons.locationArrow
                              : FontAwesomeIcons.locationPin,
                          size: 20,
                          color: Colors.blue[300],
                        )
                      ],
                    ),
                  ),
                  gapW8,
                  AppElevatedButton(
                    minimumSize: Size(size.width / 2.3, 40),
                    onPressed: () {
                      // launchUrl(
                      //   Uri.parse('tel://${widget.client.cellphone}'),
                      // );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppText(widget.client.cellphone ?? 'No disponible',
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
                ],
              ),
              gapH8,
              AppElevatedButton(
                  minimumSize: Size(size.width, 40),
                  child: AppText(
                      widget.client.typeClient == 'client'
                          ? 'Realizar Venta'
                          : 'Realizar Cotización',
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
