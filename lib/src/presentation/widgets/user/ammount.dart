import 'package:bexmovil/src/presentation/blocs/sale/sale_bloc.dart';
import 'package:bexmovil/src/utils/constants/gaps.dart';
import 'package:bexmovil/src/utils/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Ammount extends StatefulWidget {
  const Ammount({super.key});

  @override
  AmmountState createState() => AmmountState();
}

class AmmountState extends State<Ammount> {
  late SaleBloc saleBloc;
  @override
  void initState() {
    saleBloc = BlocProvider.of<SaleBloc>(context);
    super.initState();
  }

  int cantidad = 0;

  void reducirCantidad() {
    if (cantidad > 0) {
      setState(() {
        cantidad--;
      });
    }
  }

  void aumentarCantidad() {
    setState(() {
      cantidad++;
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
            borderRadius: BorderRadius.circular(Const.radius),
            elevation: Const.elevation,
            color: theme.colorScheme.secondary,
            child: SizedBox(
                height: 30,
                width: 30,
                child:
                    Icon(Icons.remove, color: theme.colorScheme.onSecondary)),
          ),
        ),
        gapW4,
        Text(
          '$cantidad',
          style: const TextStyle(fontSize: 18.0, color: Colors.black),
        ),
        gapW4,
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
