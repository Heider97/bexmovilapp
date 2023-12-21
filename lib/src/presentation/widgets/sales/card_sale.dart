// ignore_for_file: must_be_immutable

import 'package:bexmovil/src/utils/constants/gaps.dart';
import 'package:flutter/material.dart';
import 'package:googleapis/cloudsearch/v1.dart';

class CardSale extends StatelessWidget {
  String state;
  String date;
  String client;
  Function eventCard;
  String codeSale;
  double totalValue;

  CardSale({
    super.key, 
    required this.state, 
    required this.date, 
    required this.eventCard, 
    required this.totalValue, 
    required this.codeSale, 
    required this.client, 
  });

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: () => eventCard(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 6),
        child: Container(
          width: 145,
          height: 120,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(codeSale, style: const TextStyle(color: Colors.greenAccent)),
                        gapH8,
                        Text("Cliente: $client", style: const TextStyle(),),
                        Text("Estado: $state", style: const TextStyle(),),
                        
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("Fecha venta: $date", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
                        Text("Valor venta: $totalValue", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11))
                        
                      ],
                    ),
                  ],
                ),
                
                      
            ],
          )
        ),
      ),
    );
  }
}