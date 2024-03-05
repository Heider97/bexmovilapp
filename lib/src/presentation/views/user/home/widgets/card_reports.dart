import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

//widgets
import '../../../../widgets/atoms/app_text.dart';

class CardReports extends StatelessWidget {
  final IconData iconCard;
  final String title;
  final String urlIcon;
  final Function eventCard;

  const CardReports(
      {super.key,
      required this.iconCard,
      required this.title,
      required this.urlIcon,
      required this.eventCard});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => eventCard(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Card(
            child: SizedBox(
              width: 400,
              height: 90,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SvgPicture.asset(urlIcon, width: 40, height: 40),
                        AppText(title, fontSize: 16, fontWeight: FontWeight.bold),
                      ],
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
