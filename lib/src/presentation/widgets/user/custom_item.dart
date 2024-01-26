import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomItem extends StatelessWidget {
  final String iconName;
  final String imagePath;
  final Function() onTap;
  const CustomItem(
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
          SvgPicture.asset(imagePath, width: 60, height: 60),
          Text(iconName)
        ],
      ),
    );
  }
}
