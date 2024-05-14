import 'package:bexmovil/src/utils/constants/strings.dart';
import 'package:flutter/material.dart';

class CustomTextEditing extends StatelessWidget {
  final TextEditingController controller;
  const CustomTextEditing({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextFormField(
        controller: controller,
        style: theme.textTheme.bodyMedium,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          filled: true,
            fillColor: Color.fromARGB(255, 240, 239, 239),
          contentPadding: const EdgeInsets.symmetric(
            //  vertical: Const.space5,
            vertical: 1,
            horizontal: Const.space5,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
                5.0), // Ajusta el radio para cambiar la cantidad de redondez
            borderSide:
                BorderSide.none, // Puedes establecer un borde si lo deseas
          ),
        ));
  }
}
