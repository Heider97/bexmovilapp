import 'package:bexmovil/src/utils/constants/strings.dart';
import 'package:flutter/material.dart';

class FilterButton extends StatefulWidget {
  final String textButton;
  final bool enable;
  final void Function()? onTap;

  const FilterButton(
      {super.key,
      required this.textButton,
      required this.enable,
      required this.onTap});

  @override
  State<FilterButton> createState() => _FilterButtonState();
}

class _FilterButtonState extends State<FilterButton> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(Const.padding),
      child: InkWell(
        onTap: widget.onTap,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Const.radius),
              color: widget.enable
                  ? theme.primaryColor
                  : theme.colorScheme.secondary,
              border: Border.all(
                color: theme.scaffoldBackgroundColor, // Color del borde
                width: 2.0, // Ancho del borde
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2), // Color de la sombra
                  blurRadius: 5, // Radio de difuminado de la sombra
                  offset: const Offset(0, 3), // Desplazamiento de la sombra
                ),
              ]),
          child: Padding(
            padding: const EdgeInsets.only(
                top: Const.padding,
                bottom: Const.padding,
                left: Const.space15,
                right: Const.space15),
            child: Text(
              widget.textButton,
              style: theme.textTheme.bodyMedium!.copyWith(
                color: widget.enable
                    ? theme.scaffoldBackgroundColor
                    : theme.primaryColor, // Color del texto
              ),
            ),
          ),
        ),
      ),
    );
  }
}
