
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//blocs
import '../../../../blocs/sale/sale_bloc.dart';

//utils
import '../../../../../utils/constants/gaps.dart';
import '../../../../../utils/extensions/string_extension.dart';
import '../../../../../utils/constants/strings.dart';

//domain
import '../../../../../domain/models/product.dart';

//widgets
import '../../../../widgets/atomsbox.dart';

class CardProductNormalSale extends StatefulWidget {
  final Product product;

  const CardProductNormalSale({super.key, required this.product});

  @override
  State<CardProductNormalSale> createState() => _CardProductNormalSaleState();
}

class _CardProductNormalSaleState extends State<CardProductNormalSale> {
  late SaleBloc saleBloc;

  @override
  void initState() {
    saleBloc = BlocProvider.of<SaleBloc>(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return AppCard.filled(
      onTap: () {},
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: AppListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: 2,
                  child: AppText(widget.product.nomProducto,
                      maxLines: 2,
                      fontWeight: FontWeight.normal,
                      fontSize: 12,
                      overflow: TextOverflow.ellipsis),
                ),
                Flexible(
                  child: AppText(
                    'Código: ${widget.product.codProducto}',
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    overflow:
                        TextOverflow.ellipsis, // Cambiado overflow a visible
                  ),
                ),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                gapH4,
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
                    AppText(''.formatted(widget.product.precioProductoPrecio!),
                        fontSize: 14, overflow: TextOverflow.ellipsis),
                    const SizedBox(
                      width: 10,
                    ),
                    Opacity(
                      opacity: 0.75,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5)),
                        child: Padding(
                          padding: const EdgeInsets.all(2),
                          child: AppText(' -25 %',
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontSize: 8,
                              overflow: TextOverflow.ellipsis),
                        ),
                      ),
                    ),
                  ],
                ),
                gapH4,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Disponible: ',
                              style: TextStyle(
                                fontSize: Const.space12,
                                //   color: theme.primaryColor
                              ),
                            ),
                            TextSpan(
                              text:
                                  '${widget.product.existenciaStock!.toInt()}',
                              style: const TextStyle(fontSize: Const.space12),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Flexible(
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Agregados: ',
                              style: TextStyle(
                                fontSize: Const.space12,
                                //   color: theme.primaryColor
                              ),
                            ),
                            TextSpan(
                              text: '0',
                              style: TextStyle(fontSize: Const.space12),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                gapH4,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText('Cantidad:'),
                    gapW8,
                    Expanded(
                        child: AppTextFormField.outlined(
                            controller: TextEditingController(),
                            focusNode: FocusNode(),
                            onEditingComplete: () {
                              print('complete');
                            }))
                    // Row(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     Column(
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       children: [
                    //
                    //       ],
                    //     ),
                    //     gapW4,
                    //     // Column(
                    //     //   crossAxisAlignment: CrossAxisAlignment.start,
                    //     //   children: [
                    //     //     Row(
                    //     //       children: [
                    //     //         Container(
                    //     //           height: 40,
                    //     //           width: Screens.width(context) * 0.30,
                    //     //           decoration: BoxDecoration(
                    //     //             color: Colors.white,
                    //     //             borderRadius: BorderRadius.circular(5),
                    //     //             border: Border.all(
                    //     //               width: 1, // Grosor del borde
                    //     //             ),
                    //     //           ),
                    //     //           child: Row(
                    //     //               mainAxisAlignment:
                    //     //                   MainAxisAlignment.spaceBetween,
                    //     //               crossAxisAlignment:
                    //     //                   CrossAxisAlignment.center,
                    //     //               children: [
                    //     //                 // Expanded(
                    //     //                 //     child: TextFormField(
                    //     //                 //         onEditingComplete: () async {
                    //     //                 //           if (_validateInput(
                    //     //                 //               textController.text)) {
                    //     //                 //             try {
                    //     //                 //               // await _databaseRepository.insertCart(
                    //     //                 //               //     state
                    //     //                 //               //         .router!
                    //     //                 //               //         .dayRouter!,
                    //     //                 //               //     state
                    //     //                 //               //         .priceSelected!
                    //     //                 //               //         .codprecio!,
                    //     //                 //               //     state
                    //     //                 //               //         .warehouseSelected!
                    //     //                 //               //         .codbodega!,
                    //     //                 //               //     state
                    //     //                 //               //         .client!
                    //     //                 //               //         .id!
                    //     //                 //               //         .toString(),
                    //     //                 //               //     widget
                    //     //                 //               //         .product
                    //     //                 //               //         .codProducto!,
                    //     //                 //               //     int.parse(textController
                    //     //                 //               //         .text),
                    //     //                 //               //     'pending',
                    //     //                 //               //     DateTime.now()
                    //     //                 //               //         .toString());
                    //     //                 //               // print(
                    //     //                 //               //     'add to cart ');
                    //     //                 //
                    //     //                 //               // saleBloc.add(
                    //     //                 //               //     GetDetailsShippingCart());
                    //     //                 //               /*    context.read<SaleBloc>().add(
                    //     //                 //                     SelectProduct(
                    //     //                 //                         product:
                    //     //                 //                             widget.product)); */
                    //     //                 //
                    //     //                 //               alreadyInCar =
                    //     //                 //                   alreadyInCar! +
                    //     //                 //                       int.parse(
                    //     //                 //                           textController
                    //     //                 //                               .text);
                    //     //                 //
                    //     //                 //               textController.text = '';
                    //     //                 //               ammountFocusNode
                    //     //                 //                   .unfocus();
                    //     //                 //               showTopSnackBar(context,
                    //     //                 //                   'Producto agregado al carrito');
                    //     //                 //
                    //     //                 //               //ejecutar funcion para actualizar el stock agregado.
                    //     //                 //             } catch (error) {}
                    //     //                 //           }
                    //     //                 //         },
                    //     //                 //         focusNode: ammountFocusNode,
                    //     //                 //         onChanged: (value) {
                    //     //                 //           // _validateInputOnChange(value);
                    //     //                 //           //
                    //     //                 //           // inputValue = value;
                    //     //                 //           // try {
                    //     //                 //           //   setState(() {
                    //     //                 //           //     widget.product.cant =
                    //     //                 //           //         int.parse(inputValue);
                    //     //                 //           //   });
                    //     //                 //           // } catch (error) {
                    //     //                 //           //   print(error);
                    //     //                 //           // }
                    //     //                 //         },
                    //     //                 //         // controller: textController,
                    //     //                 //         keyboardType:
                    //     //                 //             TextInputType.number,
                    //     //                 //         decoration: InputDecoration(
                    //     //                 //           filled: true,
                    //     //                 //           fillColor: Colors.white,
                    //     //                 //           contentPadding:
                    //     //                 //               const EdgeInsets
                    //     //                 //                   .symmetric(
                    //     //                 //             //  vertical: Const.space5,
                    //     //                 //             vertical: 1,
                    //     //                 //             horizontal: 5,
                    //     //                 //           ),
                    //     //                 //           border: OutlineInputBorder(
                    //     //                 //             borderRadius:
                    //     //                 //                 BorderRadius.circular(
                    //     //                 //                     5.0), // Ajusta el radio para cambiar la cantidad de redondez
                    //     //                 //             borderSide: BorderSide
                    //     //                 //                 .none, // Puedes establecer un borde si lo deseas
                    //     //                 //           ),
                    //     //                 //         ))),
                    //     //                 // InkWell(
                    //     //                 //   onTap: () async {
                    //     //                 //     if (_validateInput(
                    //     //                 //         textController.text)) {
                    //     //                 //       try {
                    //     //                 //         // await _databaseRepository.insertCart(
                    //     //                 //         //     state.router!
                    //     //                 //         //         .dayRouter!,
                    //     //                 //         //     state
                    //     //                 //         //         .priceSelected!
                    //     //                 //         //         .codprecio!,
                    //     //                 //         //     state
                    //     //                 //         //         .warehouseSelected!
                    //     //                 //         //         .codbodega!,
                    //     //                 //         //     state.client!
                    //     //                 //         //         .id!
                    //     //                 //         //         .toString(),
                    //     //                 //         //     widget.product
                    //     //                 //         //         .codProducto!,
                    //     //                 //         //     int.parse(
                    //     //                 //         //         textController
                    //     //                 //         //             .text),
                    //     //                 //         //     'pending',
                    //     //                 //         //     DateTime.now()
                    //     //                 //         //         .toString());
                    //     //                 //         // print(
                    //     //                 //         //     'add to cart ');
                    //     //                 //
                    //     //                 //         // saleBloc.add(
                    //     //                 //         //     GetDetailsShippingCart());
                    //     //                 //         /*    context.read<SaleBloc>().add(
                    //     //                 //                     SelectProduct(
                    //     //                 //                         product:
                    //     //                 //                             widget.product)); */
                    //     //                 //         alreadyInCar = alreadyInCar! +
                    //     //                 //             int.parse(
                    //     //                 //                 textController.text);
                    //     //                 //
                    //     //                 //         textController.text = '';
                    //     //                 //         ammountFocusNode.unfocus();
                    //     //                 //         showTopSnackBar(context,
                    //     //                 //             'Producto agregado al carrito');
                    //     //                 //       } catch (error) {}
                    //     //                 //     }
                    //     //                 //   },
                    //     //                 //   child: Padding(
                    //     //                 //     padding: const EdgeInsets.all(4.0),
                    //     //                 //     child: Opacity(
                    //     //                 //       opacity: 0.75,
                    //     //                 //       child: Container(
                    //     //                 //         decoration: BoxDecoration(
                    //     //                 //           borderRadius:
                    //     //                 //               BorderRadius.circular(3),
                    //     //                 //           color: (ammountFocusNode
                    //     //                 //                       .hasFocus ==
                    //     //                 //                   false)
                    //     //                 //               ? Colors.grey[200]
                    //     //                 //               : primaryColor,
                    //     //                 //         ),
                    //     //                 //         child: Padding(
                    //     //                 //           padding:
                    //     //                 //               const EdgeInsets.all(6.0),
                    //     //                 //           child: Text(
                    //     //                 //             'Aplicar',
                    //     //                 //             style: TextStyle(
                    //     //                 //                 fontSize: 12,
                    //     //                 //                 color: (ammountFocusNode
                    //     //                 //                             .hasFocus ==
                    //     //                 //                         false)
                    //     //                 //                     ? Colors.grey[400]
                    //     //                 //                     : Colors.white),
                    //     //                 //           ),
                    //     //                 //         ),
                    //     //                 //       ),
                    //     //                 //     ),
                    //     //                 //   ),
                    //     //                 // )
                    //     //               ]),
                    //     //         ),
                    //     //       ],
                    //     //     ),
                    //     //   ],
                    //     // )
                    //   ],
                    // ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
