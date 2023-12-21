// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CardClient extends StatelessWidget {
  IconData iconCard;
  String tittle;
  int quantity;
  String urlIcon;
  Function eventCard;
  double percentage;
  int valueCard;
  CardClient({super.key, required this.iconCard, required this.tittle, required this.urlIcon, required this.eventCard, required this.quantity, required this.percentage, required this.valueCard});

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
          child: const  Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
                       
            ],
          )
        ),
      ),
    );
  }
}