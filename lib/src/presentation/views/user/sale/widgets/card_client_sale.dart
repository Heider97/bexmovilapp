import 'package:bexmovil/src/presentation/views/user/sale/widgets/detail_client.dart';
import 'package:flutter/material.dart';
import '../../../../widgets/atomsbox.dart';

class CardClientRouter extends StatelessWidget {
  final String nit;
  final String nameClient;
  final String branchClient;
  final String addressClient;
  final String? telCliente;
  final String razCliente;
  final String quotaCliente;
  final String priceCliente;
  final String paymentMethodClient;

  const CardClientRouter(
      {super.key,
      required this.nit,
      required this.nameClient,
      required this.branchClient,
      required this.addressClient,
      this.telCliente,
      required this.razCliente,
      required this.quotaCliente,
      required this.priceCliente,
      required this.paymentMethodClient});

  @override
  Widget build(BuildContext context) {
    return AppCard.filled(
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (c) => DetailClientSale(
                nameClient: nameClient,
                nit: nit,
                branchClient: branchClient,
                addressClient: addressClient,
                razClient: razCliente,
                quotaClient: quotaCliente,
                priceClient: priceCliente,
                paymentMethodClient: paymentMethodClient));
      },
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 6),
      child: AppListTile(
        title: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: AppText(nameClient,
                fontWeight: FontWeight.normal,
                fontSize: 14,
                overflow: TextOverflow.ellipsis)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText("Dirección: $addressClient", maxLines: 2, fontSize: 11),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: AppText("Cartera: 20M", fontSize: 11),
                ),
                Flexible(
                  child: AppText("Ventas: 5M", fontSize: 11),
                ),
                Flexible(
                  child: AppText("Servicio: 90%", fontSize: 11),
                ),
              ],
            ),
          ],
        ),
        trailing: AppIconButton(
            child: const Icon(Icons.add_shopping_cart, color: Colors.white)),
      ),
    );
  }
}
