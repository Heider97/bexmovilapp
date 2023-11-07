import 'package:flutter/material.dart';

//utils
import '../../../utils/constants/strings.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType? textInputType;
  final bool obscureText;
  final Widget? suffixIcon;
  final ValueChanged<String>? onChanged;
  final int? maxLength;

  const CustomTextFormField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.textInputType,
    this.obscureText = false,
    this.suffixIcon,
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
      obscureText: obscureText,
      onChanged: onChanged,
      maxLength: maxLength,
      decoration: InputDecoration(
        filled: true,
        fillColor: theme.cardColor,
        hintText: hintText,
        hintStyle:
            theme.textTheme.titleMedium!.copyWith(color: theme.disabledColor),
        suffixIcon: suffixIcon,
        contentPadding: const EdgeInsets.symmetric(
          vertical: Const.space12,
          horizontal: Const.space25,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Const.textFieldRadius),
          borderSide: const BorderSide(
            color: Color(0xFFF4F4F4),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Const.textFieldRadius),
          borderSide: BorderSide(
            color: theme.primaryColor,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Const.textFieldRadius),
          borderSide: BorderSide(color: theme.colorScheme.error, width: 5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Const.textFieldRadius),
          borderSide: BorderSide(color: theme.colorScheme.error),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Const.textFieldRadius),
          borderSide: BorderSide(color: theme.disabledColor, width: 5),
        ),
      ),
    );
  }
}
