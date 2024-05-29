import 'package:flutter/material.dart' hide Router;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//utils
import '../../../../../utils/constants/gaps.dart';
import '../../../../../utils/constants/strings.dart';
import '../../../../../utils/extensions/string_extension.dart';

//blocs
import '../../../../../presentation/blocs/sale/sale_bloc.dart';

//domain
import '../../../../../domain/models/router.dart';

//widgets
import '../../../../../presentation/widgets/atomsbox.dart';

class CardRouterSale extends StatefulWidget {
  final Router router;

  const CardRouterSale({super.key, required this.router});

  @override
  State<CardRouterSale> createState() => _CardRouterSaleState();
}

class _CardRouterSaleState extends State<CardRouterSale> {
  late SaleBloc saleBloc;

  @override
  void initState() {
    saleBloc = BlocProvider.of<SaleBloc>(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(7),
      child: InkWell(
        onTap: () {
          saleBloc.navigationService
              .goTo(AppRoutes.clientsSale, arguments: widget.router);
        },
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
                      AppText(widget.router.nameDayRouter!.capitalizeString(),
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontSize: 14,
                          overflow: TextOverflow.ellipsis),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          AppText('0%',
                              fontWeight: FontWeight.w500,
                              color: Colors.red[300],
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
                          AppText("Clientes: ${widget.router.clients ?? 0}",
                              fontWeight: FontWeight.normal,
                              color: Colors.grey[800],
                              fontSize: 14,
                              overflow: TextOverflow.ellipsis)
                        ],
                      ),
                      Row(
                        children: [
                          gapW12,
                          AppText('Clientes visitados: 0',
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
                          AppText('Prospectos: ${widget.router.prospects ?? 0}',
                              fontWeight: FontWeight.normal,
                              color: Colors.grey[800],
                              fontSize: 14,
                              overflow: TextOverflow.ellipsis)
                        ],
                      ),
                      Row(
                        children: [
                          AppText('Ventas totales: 0',
                              fontWeight: FontWeight.normal,
                              color: Colors.grey[800],
                              fontSize: 14,
                              overflow: TextOverflow.ellipsis)
                        ],
                      ),
                    ],
                  ),
                  gapH4
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
