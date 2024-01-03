// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../../utils/constants/gaps.dart';

class CardClient extends StatelessWidget {
  
  String salesEffectiveness;
  Function eventCard;
  double customerBalance;
  String lastVisit;
  int averageSales;
  String nameClient;

  CardClient({super.key, required this.lastVisit, required this.eventCard, required this.customerBalance, required this.salesEffectiveness, required this.averageSales, required this.nameClient});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 6),
      child: Container(
        width: 145,
        height: 140,
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
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(nameClient, style: const TextStyle(color: Colors.orange, fontSize: 18)),
                    gapH4,
                    Text("Saldo del cliente: $customerBalance", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11),),
                    Text("Promedio de ventas: $averageSales", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11),),
                    Text("Efectividad en la venta: $salesEffectiveness", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
                    Text("Visitado por última vez: $lastVisit", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
                    
                  ],
                ),                
              ],
            ),    
          ],
        )
      ),
    );
  }
}