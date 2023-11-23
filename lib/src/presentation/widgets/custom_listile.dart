import 'package:bexmovil/src/utils/constants/colors.dart';
import 'package:flutter/material.dart';


class CustomListile extends StatelessWidget {
  const CustomListile({super.key});

  @override
  Widget build(BuildContext context) {
    return const ListTile(
      tileColor: ColorDark.error,
    );
  }
}