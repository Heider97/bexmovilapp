import 'package:flutter/material.dart';

class CustomItem extends StatelessWidget {
  final String iconName;
  final String imagePath;
  const CustomItem(
      {super.key, required this.iconName, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [Image.asset(imagePath), Text(iconName)],
    );
  }
}
