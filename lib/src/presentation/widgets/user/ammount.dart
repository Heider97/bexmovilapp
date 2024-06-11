import 'package:bexmovil/src/domain/repositories/database_repository.dart';
import 'package:bexmovil/src/locator.dart';
import 'package:bexmovil/src/presentation/blocs/sale/sale_bloc.dart';
import 'package:bexmovil/src/utils/constants/screens.dart';
import 'package:bexmovil/src/utils/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final DatabaseRepository _databaseRepository = locator<DatabaseRepository>();

class Ammount extends StatefulWidget {
  final TextEditingController controller;
  final String codeProduct;

  const Ammount({Key? key, required this.controller, required this.codeProduct})
      : super(key: key);

  @override
  AmmountState createState() => AmmountState();
}

class AmmountState extends State<Ammount> {
  String inputValue = '';
  int cantidad = 0;
  String? _errorMessage;
  int alreadyInCar = 0;
  late FocusNode ammountFocusNode;
  late SaleBloc saleBloc;

  @override
  void initState() {
    ammountFocusNode = FocusNode();
    ammountFocusNode.addListener(_handleFocusChange);
    saleBloc = BlocProvider.of<SaleBloc>(context);
    super.initState();
  }

  void reducirCantidad() {
    widget.controller.text = (int.parse(widget.controller.text) - 1).toString();

  }

  void aumentarCantidad() {
    widget.controller.text = (int.parse(widget.controller.text) + 1).toString();
  }

  @override
  void dispose() {
    ammountFocusNode.removeListener(_handleFocusChange);
    ammountFocusNode.dispose();
    super.dispose();
  }

  void _handleFocusChange() {
    setState(() {
      _errorMessage = null;
    }); // Redibuja el widget cuando cambia el foco
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Column(
      children: [
        Row(
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
                  child:
                      Icon(Icons.remove, color: theme.colorScheme.onSecondary),
                ),
              ),
            ),
            const SizedBox(width: 10), // Agrega un espacio entre los botones
            BlocBuilder<SaleBloc, SaleState>(
              builder: (context, state) {
                return SizedBox(
                  width: 70, // Personaliza el ancho según tus necesidades
                  height: 25,
                  child: TextFormField(
                      focusNode: ammountFocusNode,
                      onChanged: (value) {
                        if (_validateInputOnChange(value)) {
                          inputValue = value;
                          try {
                            widget.controller.text = inputValue;
                          } catch (error) {
                            print(error);
                          }
                        }
                      },
                      onEditingComplete: () async {
                        if (_validateInput(widget.controller.text)) {
                          try {
                            await _databaseRepository.insertCart(
                                state.router!.dayRouter!,
                                state.priceSelected!.codprecio!,
                                state.warehouseSelected!.codbodega!,
                                state.client!.id!.toString(),
                                widget.codeProduct,
                                int.parse(widget.controller.text),
                                'pending',
                                DateTime.now().toString());
                            print('add to cart ');

                            saleBloc.add(GetDetailsShippingCart());

                            /* context.read<SaleBloc>().add(
                                                                        SelectProduct(
                                                                            product:
                                                                                widget.product)); */                           

                            ammountFocusNode.unfocus();

                            //ejecutar funcion para actualizar el stock agregado.
                          } catch (error) {
                            print('Error agregando los productos: $error');
                          }
                        }
                      },
                      controller: widget.controller,
                      style:
                          const TextStyle(fontSize: 18.0, color: Colors.black),
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
                );
              },
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
        ),
        if (_errorMessage != null)
          SizedBox(
            width: Screens.width(context) * 0.36,
            child: Text(
              _errorMessage!,
              style: TextStyle(color: Colors.red[900]),
            ),
          )
      ],
    );
  }

  bool _validateInputOnChange(String value) {
    setState(() {});
    if (value.isEmpty) {
      _errorMessage = null;
      return false;
    } else if (int.tryParse(value) == null || int.tryParse(value) == 0) {
      _errorMessage = 'Por favor ingrese un número entero válido diferente a 0';
      return false;
    } else {
      _errorMessage = null;
      return true;
    }
  }

  bool _validateInput(String value) {
    setState(() {});
    if (value.isEmpty) {
      _errorMessage = null;
      _errorMessage = 'Por favor ingrese un número';
      return false;
    } else if (int.tryParse(value) == null || int.tryParse(value) == 0) {
      _errorMessage = 'Por favor ingrese un número entero válido diferente a 0';
      return false;
    } else {
      _errorMessage = null;
      return true;
    }
  }
}
