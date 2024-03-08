import 'package:bexmovil/src/utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';
//domain
import '../../../../../domain/models/client.dart';
//widgets
import '../../../../widgets/atomsbox.dart';
import 'detail_client.dart';

class CardClientRouter extends StatelessWidget {
  final Client client;

  const CardClientRouter({super.key, required this.client});

  @override
  Widget build(BuildContext context) {
    return AppCard.filled(
      onTap: () {
        showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (c) => DetailClientSale(client: client));
      },
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 6),
      child: AppListTile(
        title: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: AppText(client.name ?? "N/A",
                fontWeight: FontWeight.normal,
                fontSize: 14,
                overflow: TextOverflow.ellipsis)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText("Dirección: ${client.address}", maxLines: 2, fontSize: 11),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: AppText(
                      "Cartera: ${client.wallet != null ? ''.formattedCompact(client.wallet.toString()) : '20M'}",
                      fontSize: 11),
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
            onPressed: null,
            child: const Icon(Icons.add_shopping_cart, color: Colors.white)),
      ),
    );
  }
}
