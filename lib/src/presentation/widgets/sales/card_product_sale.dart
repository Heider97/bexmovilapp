// ignore_for_file: must_be_immutable

import 'package:bexmovil/src/utils/constants/gaps.dart';
import 'package:flutter/material.dart';

class CardProductSale extends StatelessWidget {
  String lastVisit;
  int lastQuantitySale;
  String code;
  String image;
  double priceSale;
  int quantityAvailable;
  String birthPlace;
  CardProductSale(
      {super.key,
      required this.lastVisit,
      required this.lastQuantitySale,
      required this.code,
      required this.image,
      required this.priceSale,
      required this.quantityAvailable,
      required this.birthPlace});

  @override
  Widget build(BuildContext context) {
    int stock = 0;
    TextEditingController controller = TextEditingController(text: '$stock');
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 6),
        child: Container(
          width: 145,
          height: 185,
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
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Últuma vez el: $lastVisit",
                    style: const TextStyle(
                        fontSize: 9, fontWeight: FontWeight.bold)),
                Text("Últuma cantidad vendida: $lastQuantitySale",
                    style: const TextStyle(
                        fontSize: 9, fontWeight: FontWeight.bold))
              ],
            ),
            gapH4,
            Padding(
              padding: const EdgeInsets.only(bottom: 1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 100,
                        height: 125,
                        child: Image(image: AssetImage(image)),
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 200,
                        height: 135,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Código: $code",
                                style: const TextStyle(fontSize: 12)),
                            Text("Precio de venta: $priceSale",
                                style: const TextStyle(
                                    fontSize: 13, color: Colors.orange)),
                            Text("Disponiel: $quantityAvailable",
                                style: const TextStyle(fontSize: 12)),
                            Text("Aplicar descuento: $code",
                                style: const TextStyle(fontSize: 12)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text("Cantidad:  "),
                                GestureDetector(
                                  child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: const ShapeDecoration(
                                          shape: CircleBorder(),
                                          color:
                                              Color.fromRGBO(253, 241, 231, 1)),
                                      child: const Text(
                                        "-",
                                        style: TextStyle(color: Colors.black),
                                      )),
                                  onTap: () {
                                    int currentValue =
                                        int.tryParse(controller.text) ?? 0;
                                    controller.text = (currentValue > 0)
                                        ? "${currentValue - 1}"
                                        : "0";
                                  },
                                ),
                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 1),
                                  width: 40,
                                  child: TextField(
                                    controller: controller,
                                    maxLength: 3,
                                    textAlign: TextAlign.center,
                                    decoration: const InputDecoration(
                                      hintText: "0",
                                      border: InputBorder.none,
                                      counterText: "",
                                    ),
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                                GestureDetector(
                                  child: Container(
                                      padding: const EdgeInsets.all(6),
                                      decoration: const ShapeDecoration(
                                          shape: CircleBorder(),
                                          color: Color.fromARGB(
                                              255, 243, 119, 24)),
                                      child: const Text(
                                        "+",
                                        style: TextStyle(color: Colors.white),
                                      )),
                                  onTap: () {
                                    int currentValue =
                                        int.tryParse(controller.text) ?? 0;
                                    controller.text = "${currentValue + 1}";
                                  },
                                ),
                              ],
                            ),
                            Text("Lugar Origen: $birthPlace",
                                style: const TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )
          ]),
        ));
  }
}
