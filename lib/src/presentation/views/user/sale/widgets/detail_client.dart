import 'package:bexmovil/src/utils/constants/gaps.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class DetailClientSale extends StatelessWidget {
  String nameClient;
  String nit;
  String branchClient;
  String addressClient;
  String razClient;
  String quotaClient;
  String priceClient;
  String paymentMethodClient;

  DetailClientSale({
    super.key,
    required this.nameClient,
    required this.nit,
    required this.branchClient,
    required this.addressClient,
    required this.razClient,
    required this.quotaClient,
    required this.priceClient,
    required this.paymentMethodClient,
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
                Text(razClient,
                    style: const TextStyle(color: Colors.orange, fontSize: 13)),
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
                        "NIT: $nit",
                        Icon(
                          Icons.format_list_numbered_sharp,
                          color: colorIcons,
                          size: 15,
                        ),
                      ),
                      _paddingDetails(
                        nameClient,
                        Icon(
                          Icons.account_box_rounded,
                          color: colorIcons,
                          size: 15,
                        ),
                      ),
                      _paddingDetails(
                        addressClient,
                        Icon(
                          Icons.location_pin,
                          color: colorIcons,
                          size: 15,
                        ),
                      ),
                      _paddingDetails(
                        "Sucursal $branchClient",
                        Icon(
                          FontAwesomeIcons.debian,
                          color: colorIcons,
                          size: 15,
                        ),
                      ),
                      _paddingDetails(
                        "Cupo: ${formatCurrency.format(int.parse(quotaClient))}",
                        Icon(
                          Icons.monetization_on,
                          color: colorIcons,
                          size: 15,
                        ),
                      ),
                      _paddingDetails(
                        "Lista de precio: $priceClient",
                        Icon(
                          FontAwesomeIcons.debian,
                          color: colorIcons,
                          size: 15,
                        ),
                      ),
                      _paddingDetails(
                        "Forma de pago: $paymentMethodClient Días",
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
            child: Text(
              name,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
