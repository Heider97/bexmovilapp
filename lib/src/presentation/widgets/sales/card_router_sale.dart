 // ignore_for_file: must_be_immutable

import 'package:bexmovil/src/locator.dart';
import 'package:bexmovil/src/services/navigation.dart';
import 'package:bexmovil/src/services/preferences.dart';
import 'package:bexmovil/src/services/storage.dart';
import 'package:bexmovil/src/utils/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../utils/constants/gaps.dart';

final NavigationService _navigationService = locator<NavigationService>();

class CardRouter extends StatelessWidget {

  final LocalStorageService? storageService;
  
  String quantityClients;
  String dayRouter;
  int? visited;
  int? withSale;
  int? coverage;
  int? effectiveness;


  CardRouter({super.key,  required this.quantityClients,  required this.dayRouter, this.storageService});

  @override
  Widget build(BuildContext context) {
    

    return  GestureDetector(
      onTap: ()  async {
        Preferences.dayRouter = dayRouter;
        _navigationService.goTo(Routes.saleRoute);
        
      },
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(dayRouter, style: const TextStyle(color: Colors.orange, fontSize: 18)),
              gapH12,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  gapH12,
                  cardButtons(FontAwesomeIcons.comment, "${visited ?? '0'} %", context),
                  cardButtons(FontAwesomeIcons.retweet, "${withSale ?? '0'} %", context),
                  cardButtons(FontAwesomeIcons.heart, "${visited ?? '0'} %", context),
                  cardButtons(FontAwesomeIcons.share, "${effectiveness ?? '0'} %", context),              
                ],
              ),    
            ],
          )
        ),
      ),
    );
  }

  Widget cardButtons(IconData icon, String text, BuildContext context ){
    ThemeData theme = Theme.of(context);
    return Row(
      children: [
        Icon(
          icon,
          size: 18.0,
          color: theme.primaryColor,
        ),
        Container(
          margin: const EdgeInsets.all(6.0),
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.black45,
              fontSize: 14.0
            ),
          ),
        )
      ],
    );
  }
} 