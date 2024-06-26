import 'package:bexmovil/src/utils/constants/strings.dart';
import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType? textInputType;
  final Color? colorBackground;

  final Widget? prefixIcon;
  final ValueChanged<String>? onChanged;
  final int? maxLength;

  const CustomSearchBar({
    Key? key,
    required this.controller,
    required this.hintText,
    this.colorBackground,
    this.textInputType,
    this.prefixIcon,
    this.onChanged,
    this.maxLength,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextFormField(
        controller: controller,
        style: theme.textTheme.bodyMedium,
        keyboardType: textInputType,
        onChanged: onChanged,
        maxLength: maxLength,
        decoration: InputDecoration(
          filled: true,
          fillColor: colorBackground ?? theme.colorScheme.secondary,
          hintText: hintText,
          hintStyle: theme.textTheme.titleMedium!
              .copyWith(color: theme.colorScheme.tertiary),
          prefixIcon: prefixIcon,
          prefixIconColor: theme.primaryColor,
          contentPadding: const EdgeInsets.symmetric(
            vertical: Const.space12,
            horizontal: Const.space25,
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide.none),
        ));
  }
}
