import 'package:bexmovil/src/domain/repositories/database_repository.dart';
import 'package:bexmovil/src/locator.dart';
import 'package:bexmovil/src/utils/resources/app_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//blocs
import '../../../../../presentation/blocs/sale/sale_bloc.dart';

//utils
import '../../../../../utils/constants/gaps.dart';
import '../../../../../utils/extensions/string_extension.dart';

//domain
import '../../../../../domain/models/product.dart';

//widgets
import '../../../../widgets/atoms/app_text.dart';

final DatabaseRepository _databaseRepository = locator<DatabaseRepository>();

class CustomCardProduct extends StatefulWidget {
  final Product product;
  const CustomCardProduct({super.key, required this.product});

  @override
  State<CustomCardProduct> createState() => __CustomCardProducStateState();
}

class __CustomCardProducStateState extends State<CustomCardProduct> {
  TextEditingController textController = TextEditingController();
  late SaleBloc saleBloc;
  Color primaryColor = const Color(0xFFF27114);
  String inputValue = '';

  @override
  void initState() {
    saleBloc = BlocProvider.of<SaleBloc>(context);
    super.initState();
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
                      Row(
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
                                      // Row(
                                      //   children: [
                                      //     AppText('Antes: '),
                                      //     AppText(' \$60.000.000',
                                      //         decoration:
                                      //             TextDecoration.lineThrough,
                                      //         fontSize: 12,
                                      //         overflow: TextOverflow.ellipsis),
                                      //   ],
                                      // ),
                                      Row(
                                        children: [
                                          AppText(
                                              ''.formatted(widget.product
                                                  .precioProductoPrecio!),
                                              fontSize: 14,
                                              overflow: TextOverflow.ellipsis),
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
                                                  ))),
                                          AppText(
                                              ''.formatted(widget.product
                                                  .precioProductoPrecio!),
                                              fontSize: 14,
                                              overflow: TextOverflow.ellipsis),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Opacity(
                                            opacity: 0.75,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: primaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(2),
                                                child: AppText(' -25 %',
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white,
                                                    fontSize: 8,
                                                    overflow:
                                                        TextOverflow.ellipsis),
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
                          const SizedBox(
                            height: 4,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      AppText('Cantidad: '),
                                      AppText(
                                          'Disponible ${widget.product.existenciaStock}',
                                          fontSize: 12,
                                          color: Colors.grey[600]),
                                    ],
                                  ),
                                  gapW4,
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 40,
                                        width: 120,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                            color: (textController.text.isEmpty)
                                                ? Colors.grey[200]!
                                                : primaryColor, // Color del borde
                                            width: 1, // Grosor del borde
                                          ),
                                        ),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                  child: TextFormField(
                                                      onChanged: (value) {
                                                        inputValue = value;
                                                        setState(() {
                                                          widget.product.cant =
                                                              int.parse(
                                                                  inputValue);
                                                        });
                                                      },
                                                      controller:
                                                          textController,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      decoration:
                                                          InputDecoration(
                                                        focusColor:
                                                            primaryColor,
                                                        filled: true,
                                                        fillColor: Colors.white,
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
                                                              BorderRadius.circular(
                                                                  5.0), // Ajusta el radio para cambiar la cantidad de redondez
                                                          borderSide: BorderSide
                                                              .none, // Puedes establecer un borde si lo deseas
                                                        ),
                                                      ))),
                                              InkWell(
                                                onTap: () async {
                                                  await _databaseRepository
                                                      .insertCart(
                                                          state.router!
                                                              .dayRouter!,
                                                          state.priceSelected!
                                                              .codprecio!,
                                                          state
                                                              .warehouseSelected!
                                                              .codbodega!,
                                                          state.client!.id!
                                                              .toString(),
                                                          widget.product
                                                              .codProducto!,
                                                          5,
                                                          'pending',
                                                          DateTime.now()
                                                              .toString());
                                                  print('add to cart ');
                                                  /*    context.read<SaleBloc>().add(
                                                            SelectProduct(
                                                                product:
                                                                    widget.product)); */
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: Opacity(
                                                    opacity: 0.75,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(3),
                                                        color: (inputValue
                                                                .isEmpty)
                                                            ? Colors.grey[200]
                                                            : primaryColor,
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(6.0),
                                                        child: Text(
                                                          'Aplicar',
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color: (inputValue
                                                                      .isEmpty)
                                                                  ? Colors
                                                                      .grey[400]
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
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
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
}
