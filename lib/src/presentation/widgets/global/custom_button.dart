import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  const CustomButton({super.key, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
          color: theme.primaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: Text(buttonText, style: theme.textTheme.bodyMedium),
    );
  }
}
