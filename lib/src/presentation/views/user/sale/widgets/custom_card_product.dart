import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//blocs
import '../../../../../presentation/blocs/sale/sale_bloc.dart';

//utils
import '../../../../../utils/constants/gaps.dart';
import '../../../../../utils/constants/screens.dart';
import '../../../../../utils/extensions/string_extension.dart';

//domain
import '../../../../../domain/models/product.dart';

//widgets
import '../../../../widgets/atoms/app_text.dart';

class CustomCardProduct extends StatefulWidget {
  final Product product;
  const CustomCardProduct({super.key, required this.product});

  @override
  State<CustomCardProduct> createState() => __CustomCardProducStateState();
}

class __CustomCardProducStateState extends State<CustomCardProduct> {

  TextEditingController textController = TextEditingController();
  TextEditingController suggestion = TextEditingController();

  late SaleBloc saleBloc;
  late FocusNode ammountFocusNode;

  Color primaryColor = const Color(0xFFF27114);

  String? _errorMessage;
  String inputValue = '';

  int? alreadyInCar;

  bool editMode = false;

  @override
  void initState() {
    //ejecutar funcion para ver si ya tengo stock agregado.

    saleBloc = BlocProvider.of<SaleBloc>(context);

    findAmmountAlreadyInCar(
        saleBloc.state.router!.dayRouter!,
        saleBloc.state.priceSelected!.codprecio!,
        saleBloc.state.warehouseSelected!.codbodega!,
        saleBloc.state.client!.id!.toString(),
        widget.product.codProducto!);

    ammountFocusNode = FocusNode();
    ammountFocusNode.addListener(_handleFocusChange);

    super.initState();
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

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<SaleBloc, SaleState>(
        builder: (context, state) {
          return InkWell(
            onTap: () {
              showProductDialog(context: context);
            },
            child: Material(
              elevation: 1,
              child: Container(
                decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(4)),
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 1,
                              child: AppText(
                                widget.product.nomProducto.toLowerCase(),
                                maxLines: 2,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                                fontSize: 14,
                                overflow: TextOverflow
                                    .ellipsis, // Trunca el texto si supera las dos líneas
                              ),
                            ),
                            Row(
                              children: [
                                const SizedBox(width: 20),
                                AppText(
                                  'Código: \n${widget.product.codProducto}',
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                  fontSize: 12,
                                  overflow: TextOverflow
                                      .visible, // Cambiado overflow a visible
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Center(
                                child: Opacity(
                                  opacity: 0.75,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.grey[350],
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(2),
                                      child: AppText('Imagen\n no disponible.',
                                          textAlign: TextAlign.center,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                          fontSize: 12,
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                  ),
                                ),
                              )),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              AppText('Antes: '),
                                              AppText(' \$60.000.000',
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                  fontSize: 12,
                                                  overflow:
                                                  TextOverflow.ellipsis),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Column(
                                                children: [
                                                  AppText('cop '),
                                                  const SizedBox(
                                                    height: 10,
                                                  )
                                                ],
                                              ),
                                              AppText(
                                                  ''.formatted(widget.product
                                                      .precioProductoPrecio!),
                                                  fontSize: 14,
                                                  overflow:
                                                  TextOverflow.ellipsis),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Opacity(
                                                opacity: 0.75,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: primaryColor,
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          5)),
                                                  child: Padding(
                                                    padding:
                                                    const EdgeInsets.all(2),
                                                    child: AppText(' -25 %',
                                                        fontWeight:
                                                        FontWeight.w500,
                                                        color: Colors.white,
                                                        fontSize: 8,
                                                        overflow: TextOverflow
                                                            .ellipsis),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              AppText(
                                'Disponible: ${widget.product.existenciaStock!.toInt()}',
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Opacity(
                                    opacity: 0.5,
                                    child: Container(
                                      child: AppText(
                                        fontSize: 12,
                                        'Agregados: ${alreadyInCar ?? 0}', //color: primaryColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          AppText('Cant:'),
                                        ],
                                      ),
                                      gapW4,
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                height: 40,
                                                width: Screens.width(context) *
                                                    0.30,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  border: Border.all(
                                                    color: (ammountFocusNode
                                                                .hasFocus ==
                                                            false)
                                                        ? Colors.grey[200]!
                                                        : primaryColor, // Color del borde
                                                    width:
                                                        1, // Grosor del borde
                                                  ),
                                                ),
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Expanded(
                                                          child: TextFormField(
                                                              onEditingComplete:
                                                                  () async {
                                                                if (_validateInput(
                                                                    textController
                                                                        .text)) {
                                                                  try {
                                                                    await _databaseRepository.insertCart(
                                                                        state
                                                                            .router!
                                                                            .dayRouter!,
                                                                        state
                                                                            .priceSelected!
                                                                            .codprecio!,
                                                                        state
                                                                            .warehouseSelected!
                                                                            .codbodega!,
                                                                        state
                                                                            .client!
                                                                            .id!
                                                                            .toString(),
                                                                        widget
                                                                            .product
                                                                            .codProducto!,
                                                                        int.parse(textController
                                                                            .text),
                                                                        'pending',
                                                                        DateTime.now()
                                                                            .toString());
                                                                    print(
                                                                        'add to cart ');

                                                                    saleBloc.add(
                                                                        GetDetailsShippingCart());
                                                                    /*    context.read<SaleBloc>().add(
                                                            SelectProduct(
                                                                product:
                                                                    widget.product)); */

                                                                    alreadyInCar =
                                                                        alreadyInCar! +
                                                                            int.parse(textController.text);

                                                                    textController
                                                                        .text = '';
                                                                    ammountFocusNode
                                                                        .unfocus();
                                                                    showTopSnackBar(
                                                                        context,
                                                                        'Producto agregado al carrito');

                                                                    //ejecutar funcion para actualizar el stock agregado.
                                                                  } catch (error) {}
                                                                }
                                                              },
                                                              focusNode:
                                                                  ammountFocusNode,
                                                              onChanged:
                                                                  (value) {
                                                                _validateInputOnChange(
                                                                    value);

                                                                inputValue =
                                                                    value;
                                                                try {
                                                                  setState(() {
                                                                    widget.product
                                                                            .cant =
                                                                        int.parse(
                                                                            inputValue);
                                                                  });
                                                                } catch (error) {
                                                                  print(error);
                                                                }
                                                              },
                                                              controller:
                                                                  textController,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              decoration:
                                                                  InputDecoration(
                                                                focusColor:
                                                                    primaryColor,
                                                                filled: true,
                                                                fillColor:
                                                                    Colors
                                                                        .white,
                                                                contentPadding:
                                                                    const EdgeInsets
                                                                        .symmetric(
                                                                  //  vertical: Const.space5,
                                                                  vertical: 1,
                                                                  horizontal: 5,
                                                                ),
                                                                border:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5.0), // Ajusta el radio para cambiar la cantidad de redondez
                                                                  borderSide:
                                                                      BorderSide
                                                                          .none, // Puedes establecer un borde si lo deseas
                                                                ),
                                                              ))),
                                                      InkWell(
                                                        onTap: () async {
                                                          if (_validateInput(
                                                              textController
                                                                  .text)) {
                                                            try {
                                                              await _databaseRepository.insertCart(
                                                                  state.router!
                                                                      .dayRouter!,
                                                                  state
                                                                      .priceSelected!
                                                                      .codprecio!,
                                                                  state
                                                                      .warehouseSelected!
                                                                      .codbodega!,
                                                                  state.client!
                                                                      .id!
                                                                      .toString(),
                                                                  widget.product
                                                                      .codProducto!,
                                                                  int.parse(
                                                                      textController
                                                                          .text),
                                                                  'pending',
                                                                  DateTime.now()
                                                                      .toString());
                                                              print(
                                                                  'add to cart ');

                                                              saleBloc.add(
                                                                  GetDetailsShippingCart());
                                                              /*    context.read<SaleBloc>().add(
                                                            SelectProduct(
                                                                product:
                                                                    widget.product)); */
                                                              alreadyInCar =
                                                                  alreadyInCar! +
                                                                      int.parse(
                                                                          textController
                                                                              .text);

                                                              textController
                                                                  .text = '';
                                                              ammountFocusNode
                                                                  .unfocus();
                                                              showTopSnackBar(
                                                                  context,
                                                                  'Producto agregado al carrito');
                                                            } catch (error) {}
                                                          }
                                                        },
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(4.0),
                                                          child: Opacity(
                                                            opacity: 0.75,
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            3),
                                                                color: (ammountFocusNode
                                                                            .hasFocus ==
                                                                        false)
                                                                    ? Colors
                                                                        .grey[200]
                                                                    : primaryColor,
                                                              ),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        6.0),
                                                                child: Text(
                                                                  'Aplicar',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      color: (ammountFocusNode.hasFocus ==
                                                                              false)
                                                                          ? Colors.grey[
                                                                              400]
                                                                          : Colors
                                                                              .white),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    ]),
                                              ),
                                              SizedBox(
                                                width: 2,
                                              )
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
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
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
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

  void _validateInputOnChange(String value) {
    setState(() {});
    if (value.isEmpty) {
      _errorMessage = null;
    } else if (int.tryParse(value) == null || int.tryParse(value) == 0) {
      _errorMessage = 'Por favor ingrese un número entero válido diferente a 0';
    } else {
      _errorMessage = null;
    }
  }

  void showTopSnackBar(BuildContext context, String message) {
    Flushbar(
      message: message,
      margin: EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(8),
      duration: Duration(seconds: 3),
      flushbarPosition: FlushbarPosition.TOP,
      icon: Icon(
        Icons.info,
        color: Colors.white,
      ),
    ).show(context);
  }

  Future<void> findAmmountAlreadyInCar(String codrouter, String codPrecio,
      String codBodega, String codcliente, String productId) async {
    alreadyInCar =
        await _databaseRepository.getTotalProductQuantityAlreadyExist(
            codrouter, codPrecio, codBodega, codcliente, productId);
  }
}
