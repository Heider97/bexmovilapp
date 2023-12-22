// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';


class CardProductSale extends StatelessWidget {
  IconData iconCard;
  String tittle;
  int quantity;
  String urlIcon;
  Function eventCard;
  double percentage;
  int valueCard;
  CardProductSale({super.key, required this.iconCard, required this.tittle, required this.urlIcon, required this.eventCard, required this.quantity, required this.percentage, required this.valueCard});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 6),
      child: Container(
        width: 145,
        height: 180,
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
                    
                    
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    
                    
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