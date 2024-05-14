import 'package:bexmovil/src/utils/constants/strings.dart';
import 'package:flutter/material.dart';

class Ammount extends StatefulWidget {
  final TextEditingController controller;

  const Ammount({Key? key, required this.controller}) : super(key: key);

  @override
  AmmountState createState() => AmmountState();
}

class AmmountState extends State<Ammount> {
  int cantidad = 0;

  void reducirCantidad() {
    if (cantidad > 0) {
      setState(() {
        cantidad--;
        widget.controller.text = cantidad.toString();
      });
    }
  }

  void aumentarCantidad() {
    setState(() {
      cantidad++;
      widget.controller.text = cantidad.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            reducirCantidad();
          },
          child: Material(
            borderRadius: BorderRadius.circular(
                20), // Personaliza el radio según tus necesidades
            elevation: 2, // Personaliza la elevación según tus necesidades
            color: theme.colorScheme.secondary,
            child: SizedBox(
              height: 30,
              width: 30,
              child: Icon(Icons.remove, color: theme.colorScheme.onSecondary),
            ),
          ),
        ),
        const SizedBox(width: 10), // Agrega un espacio entre los botones
        SizedBox(
          width: 70, // Personaliza el ancho según tus necesidades
          height: 25,
          child: TextFormField(
              controller: widget.controller,
              style: const TextStyle(fontSize: 18.0, color: Colors.black),
              textAlign: TextAlign.center,
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
                  borderSide: BorderSide
                      .none, // Puedes establecer un borde si lo deseas
                ),
              )),
        ),
        SizedBox(width: 10), // Agrega un espacio entre los botones
        InkWell(
          onTap: () {
            aumentarCantidad();
          },
          child: Material(
            borderRadius: BorderRadius.circular(Const.radius),
            elevation: Const.elevation,
            color: theme.primaryColor,
            child: SizedBox(
                height: 30,
                width: 30,
                child: Icon(Icons.add, color: theme.colorScheme.onPrimary)),
          ),
        ),
      ],
    );
  }
}
