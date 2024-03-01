// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../../utils/constants/gaps.dart';

class CardClientRouter extends StatelessWidget {
  String nit;
  String nameClient;
  String branchClient;
  String addressClient;

  CardClientRouter(
      {super.key,
      required this.nit,
      required this.nameClient,
      required this.branchClient,
      required this.addressClient});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 6),
        child: Container(
            width: double.infinity,
            height: 110,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 1,
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(nameClient,
                            style: const TextStyle(
                                color: Colors.orange, fontSize: 15)),
                        gapH4,
                        Text(
                          "Nit: $nit",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 11),
                        ),
                        Text(
                          "SUC: $branchClient",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 11),
                        ),
                        Text(
                          "Dirección: $addressClient",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 11),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
