import 'package:flutter/material.dart';
//utils
import '../../../../../utils/extensions/string_extension.dart';
//domain
import '../../../../../domain/models/client.dart';
//widgets
import '../../../../widgets/atomsbox.dart';

class CardClientWallet extends StatelessWidget {
  final Client client;
  final Function() onTap;

  const CardClientWallet(
      {super.key, required this.client, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return AppCard.filled(
      onTap: onTap,
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
            AppText("Facturas Vencidas: ${client.total}",
                maxLines: 2, fontSize: 11),
            if (client.wallet != null)
              AppText("Cartera: ${''.formatted(client.wallet!.toDouble())}",
                  maxLines: 2, fontSize: 11),
          ],
        ),
      ),
    );
  }
}
