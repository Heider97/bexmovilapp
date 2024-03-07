import 'package:flutter/material.dart';
//domain
import '../../../../../domain/models/client.dart';
//widgets
import '../../../../widgets/atomsbox.dart';

class CardClientWallet extends StatelessWidget {
  final Client client;

  const CardClientWallet(
      {super.key,
        required this.client});

  @override
  Widget build(BuildContext context) {
    return AppCard.filled(
      onTap: () {

      },
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 6),
      child: AppListTile(
        title: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: AppText(client.nomCliente ?? "N/A",
                fontWeight: FontWeight.normal,
                fontSize: 14,
                overflow: TextOverflow.ellipsis)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText("Facturas Vencidad: ${client.dirCliente}", maxLines: 2, fontSize: 11),
            AppText("Cartera: ${client.dirCliente}", maxLines: 2, fontSize: 11),

          ],
        ),
      ),
    );
  }
}
