import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
//utils
import '../../../../../utils/constants/gaps.dart';
//domain
import '../../../../../domain/models/client.dart';
//widgets
import '../../../../widgets/atomsbox.dart';

// ignore: must_be_immutable
class DetailClientSale extends StatelessWidget {
  final Client client;

  const DetailClientSale({
    super.key,
    required this.client,
  });

  @override
  Widget build(BuildContext context) {
    final formatCurrency = NumberFormat.simpleCurrency();
    ThemeData theme = Theme.of(context);
    Color colorIcons = theme.primaryColor;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(client.businessName ?? "N/A",
                    color: Colors.orange, fontSize: 13),
                IconButton(
                    onPressed: () {}, icon: const Icon(Icons.location_on))
              ],
            ),
            gapH20,
            Positioned(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _paddingDetails(
                        "NIT: ${client.nit}",
                        Icon(
                          Icons.format_list_numbered_sharp,
                          color: colorIcons,
                          size: 15,
                        ),
                      ),
                      _paddingDetails(
                        client.name ?? "N/A",
                        Icon(
                          Icons.account_box_rounded,
                          color: colorIcons,
                          size: 15,
                        ),
                      ),
                      _paddingDetails(
                        client.address ?? "N/A",
                        Icon(
                          Icons.location_pin,
                          color: colorIcons,
                          size: 15,
                        ),
                      ),
                      _paddingDetails(
                        "Sucursal ${client.branch}",
                        Icon(
                          FontAwesomeIcons.debian,
                          color: colorIcons,
                          size: 15,
                        ),
                      ),
                      _paddingDetails(
                        "Cupo: ${formatCurrency.format(client.quota)}",
                        Icon(
                          Icons.monetization_on,
                          color: colorIcons,
                          size: 15,
                        ),
                      ),
                      _paddingDetails(
                        "Lista de precio: ${client.price}",
                        Icon(
                          FontAwesomeIcons.debian,
                          color: colorIcons,
                          size: 15,
                        ),
                      ),
                      _paddingDetails(
                        "Forma de pago: ${client.wayToPay} Días",
                        Icon(
                          FontAwesomeIcons.debian,
                          color: colorIcons,
                          size: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            gapH12,
            ElevatedButton(onPressed: () {}, child: const Text("Vender")),
          ],
        ),
      ),
    );
  }

  Widget _paddingDetails(String name, Icon icon) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Padding(padding: const EdgeInsets.only(right: 5), child: icon),
          Flexible(
            child: AppText(
              name,
              color: Colors.black87,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
