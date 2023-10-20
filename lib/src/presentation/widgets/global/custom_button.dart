import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String butonText;
  const CustomButton({super.key, required this.butonText});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
          color: theme.primaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: Text(butonText, style: theme.textTheme.bodyMedium),
    );
  }
}
