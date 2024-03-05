// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../../utils/constants/gaps.dart';

class CardRouter extends StatelessWidget {
  String quantityClients;
  String dayRouter;
  int? visited;
  int? withSale;
  int? coverage;
  int? effectiveness;

  CardRouter(
      {super.key, required this.quantityClients, required this.dayRouter});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 6),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Card(
            elevation: 5,
            color: Colors.white,
            surfaceTintColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(dayRouter,
                                style: const TextStyle(
                                    color: Colors.orange, fontSize: 18)),
                            gapH4,
                            Text(
                              "Cantidad clientes: $quantityClients",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 11),
                            ),
                            Text(
                              "Visitados: ${visited ?? '0'} %",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 11),
                            ),
                            Text(
                              "Con venta: ${withSale ?? '0'} %",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 11),
                            ),
                            Text(
                              "Efectividad: ${effectiveness ?? '0'} %",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 11),
                            ),
                            Text(
                              "Cobertura: ${coverage ?? '0'} %",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 11),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
