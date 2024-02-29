 // ignore_for_file: must_be_immutable

import 'package:bexmovil/src/locator.dart';
import 'package:bexmovil/src/services/navigation.dart';
import 'package:bexmovil/src/utils/constants/strings.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/gaps.dart';

final NavigationService _navigationService = locator<NavigationService>();

class CardRouter extends StatelessWidget {
  
  String quantityClients;
  String dayRouter;
  int? visited;
  int? withSale;
  int? coverage;
  int? effectiveness;


  CardRouter({super.key,  required this.quantityClients,  required this.dayRouter});

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: () => { _navigationService.goTo(Routes.saleRoute) },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 6),
        child: Container(
          width: double.infinity,
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
                      Text(dayRouter, style: const TextStyle(color: Colors.orange, fontSize: 18)),
                      gapH4,
                      Text("Cantidad clientes: $quantityClients", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11),),
                      Text("Visitados: ${visited ?? '0'} %", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11),),
                      Text("Con venta: ${withSale ?? '0'} %", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11),),
                      Text("Efectividad: ${effectiveness ?? '0'} %", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11),),
                      Text("Cobertura: ${coverage ?? '0'} %", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11),),
                      
                      
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