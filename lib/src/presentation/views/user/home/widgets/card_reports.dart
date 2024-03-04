import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
        child: Container(
            width: 400,
            height: 90,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(blurRadius: 3, offset: Offset(0, 5))
                ]),
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
            )),
      ),
    );
  }
}
