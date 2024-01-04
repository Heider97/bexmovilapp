import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomItem extends StatelessWidget {
  final String iconName;
  final String imagePath;
  const CustomItem(
      {super.key, required this.iconName, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [SvgPicture.asset(imagePath, width: 60, height: 60), Text(iconName)],
    );
  }
}
