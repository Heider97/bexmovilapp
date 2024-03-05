import 'package:bexmovil/src/utils/constants/strings.dart';
import 'package:flutter/material.dart';

class MultiTextFormField extends StatelessWidget {
  const MultiTextFormField({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return TextFormField(
        keyboardType: TextInputType.text,
        maxLines: 4,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            vertical: Const.space12,
            horizontal: Const.space25,
          ),
          hintText: 'Escriba aquí sus observaciones',
          hintStyle:
              theme.textTheme.titleMedium!.copyWith(color: theme.disabledColor),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Const.textFieldRadius),
            borderSide: const BorderSide(
              color: Color(0XFFD9D9D9),
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
            borderSide: BorderSide(color: theme.colorScheme.error, width: 1),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Const.textFieldRadius),
            borderSide: BorderSide(color: theme.colorScheme.error),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Const.textFieldRadius),
            borderSide: BorderSide(color: theme.disabledColor, width: 1),
          ),
        ),
        onChanged: (value) {});
  }
}
