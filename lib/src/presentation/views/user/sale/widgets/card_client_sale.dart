import 'package:flutter/material.dart';
import 'package:bexmovil/src/presentation/widgets/atomsbox.dart';

class CardClientRouter extends StatelessWidget {
  final String nit;
  final String nameClient;
  final String branchClient;
  final String addressClient;

  const CardClientRouter(
      {super.key,
      required this.nit,
      required this.nameClient,
      required this.branchClient,
      required this.addressClient});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        print('pressed');
      },
      onTap: () => {},
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 6),
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 1,
                ),
              ],
            ),
            child: AppListTile(
              title: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: AppText(nameClient, overflow: TextOverflow.ellipsis)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText("Nit: $nit",
                      fontWeight: FontWeight.bold, fontSize: 11),
                  AppText("SUC: $branchClient",
                      fontWeight: FontWeight.bold, fontSize: 11),
                  AppText("Dirección: $addressClient",
                      fontWeight: FontWeight.bold, fontSize: 11),
                ],
              ),
              trailing: AppIconButton(
                  child:
                      const Icon(Icons.add_shopping_cart, color: Colors.white)),
            ),
          )),
    );
  }
}
