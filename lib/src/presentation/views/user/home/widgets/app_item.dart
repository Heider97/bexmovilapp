import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../widgets/atoms/app_text.dart';

class AppItem extends StatelessWidget {
  final String iconName;
  final String imagePath;
  final Function() onTap;
  const AppItem(
      {super.key,
      required this.iconName,
      required this.imagePath,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            child: SvgPicture.asset(
              imagePath,
              width: 40,
              height: 40,
            ),
          ),
          AppText(iconName)
        ],
      ),
    );
  }
}
