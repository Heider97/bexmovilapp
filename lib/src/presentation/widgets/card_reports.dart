// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CardReports extends StatelessWidget {
  IconData iconCard;
  String tittle;
  String urlIcon;
  final Function eventCard;
  CardReports({super.key, required this.iconCard, required this.tittle, required this.urlIcon, required this.eventCard});

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: () => eventCard(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Container(
          width: 400,
          height: 90,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 3,
                offset: Offset(0, 5)
              )
            ]
          ),
          child:   Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image(image: AssetImage(urlIcon)),
                  Text(tittle, style: const TextStyle(fontSize: 17, color: Colors.black87, fontWeight: FontWeight.bold),),
                  Icon(iconCard, color: Colors.yellow,)
    
                ],
              ),
            ],
          )
        ),
      ),
    );
  }
}