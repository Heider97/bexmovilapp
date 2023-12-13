// ignore_for_file: must_be_immutable

import 'package:bexmovil/src/utils/constants/gaps.dart';
import 'package:flutter/material.dart';

class CardKpi extends StatelessWidget {
  IconData iconCard;
  String tittle;
  int quantity;
  String urlIcon;
  Function eventCard;
  double percentage;
  int valueCard;
  CardKpi({super.key, required this.iconCard, required this.tittle, required this.urlIcon, required this.eventCard, required this.quantity, required this.percentage, required this.valueCard});

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: () => eventCard(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 6),
        child: Container(
          width: 145,
          height: 190,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(tittle, style: const TextStyle(fontSize: 8, fontWeight: FontWeight.bold)),
              gapH4,
              Row(
                children: [
                  Text(quantity.toString(), style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),               
                                      
                  if (percentage < 0) ...[
                    const Icon( Icons.arrow_circle_down_sharp, size: 20, color: Colors.redAccent),
                    Text(" ${percentage.toString()}%", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.redAccent)),
                  ] else...[
                    const Icon( Icons.arrow_circle_up_rounded, size: 20, color: Colors.greenAccent),
                    Text(" +${percentage.toString()}%", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.greenAccent)),
                  ],                  
                ]
              ),
              gapH12,
              Row(
                children: [
                  valueCard == 1 ? const Text("Ventas pendientes", style: TextStyle(fontSize: 7)) : const Text("Prospectos creados", style: TextStyle(fontSize: 7)),
                ],
                
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: percentage > 0 ? Colors.greenAccent : Colors.redAccent,width: 1.0),
                  ),
                ),
              ) ,
              Row(
                children: [
                  valueCard == 1 ? const Text("Ventas totales", style: TextStyle(fontSize: 7)) : const Text("Prospectos visitados", style: TextStyle(fontSize: 7)),
                ],                
              ),             
            ],
          )
        ),
      ),
    );
  }
}