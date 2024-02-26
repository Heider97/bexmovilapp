 // ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../../utils/constants/gaps.dart';

class CardRouter extends StatelessWidget {
  
  String quantityClients;
  String dayRouter;
  String priceList;

  CardRouter({super.key,  required this.quantityClients,  required this.dayRouter, required this.priceList});

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: () => print("Hola card Ruter"),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 6),
        child: Container(
          width: double.infinity,
          height: 100,
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
                      Text("Número del rutero: $dayRouter", style: const TextStyle(color: Colors.orange, fontSize: 18)),
                      gapH4,
                      Text("Cantidad clientes: $quantityClients", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11),),
                      Text("Lista de precio: $priceList", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11),),
                      
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