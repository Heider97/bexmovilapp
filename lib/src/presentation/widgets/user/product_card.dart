import 'package:bexmovil/src/domain/models/porduct.dart';
import 'package:bexmovil/src/presentation/widgets/atoms/app_text.dart';

import 'package:bexmovil/src/presentation/widgets/user/custom_paint.dart';
import 'package:bexmovil/src/presentation/widgets/user/custom_text_editing.dart';
import 'package:bexmovil/src/presentation/widgets/user/expanded_section.dart';
import 'package:bexmovil/src/presentation/widgets/user/image_with_shadow.dart';
import 'package:bexmovil/src/utils/constants/gaps.dart';
import 'package:bexmovil/src/utils/constants/screens.dart';
import 'package:bexmovil/src/utils/constants/strings.dart';
import 'package:bexmovil/src/utils/extensions/date_time_extension.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatefulWidget {
  final Product product;
  final VoidCallback refresh;

  const ProductCard({super.key, required this.product, required this.refresh});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

TextEditingController discountController = TextEditingController();

class _ProductCardState extends State<ProductCard> {
  bool expand = false;
  late int cantidad;

  @override
  void initState() {
    cantidad = widget.product.quantity;
    super.initState();
  }

  void reducirCantidad() {
    if (cantidad > 0) {
      setState(() {
        widget.product.quantity--;
        cantidad--;
        widget.refresh();
      });
    }
  }

  void aumentarCantidad() {
    if (cantidad < widget.product.availableUnits) {
      setState(() {
        widget.product.quantity++;
        cantidad++;
        widget.refresh();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Column(
      children: [
        Padding(
          padding:
              const EdgeInsets.only(left: Const.padding, right: Const.padding),
          child: CustomPaint(
            //  size: Size(200, 400),
            painter: CustomShapePainter(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(children: [
                  Positioned(
                      right: 3,
                      bottom: 1,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            expand = !expand;
                          });
                        },
                        child: Container(
                          color: Colors.transparent,
                          width: 120,
                          height: 20,
                          child: Center(
                            child: Text(
                              !expand ? "Ver más" : 'Ver menos',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      )),
                  Column(
                    children: [
                      gapH12,
                      
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                AppText('Última cantidad vendida: ',
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                    fontSize: 16,
                                    overflow: TextOverflow.ellipsis),
                                AppText(
                                    widget.product.lastQuantitySold.toString(),
                                      
                                    fontWeight: FontWeight.normal,
                                    color: Colors.grey[700],
                                    fontSize: 12,
                                    overflow: TextOverflow.ellipsis)
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              AppText('Última cantidad vendida: ',
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                  fontSize: 16,
                                  overflow: TextOverflow.ellipsis),
                              AppText(
                                  widget.product.lastSoldOn?.formatTime() ??
                                      "No especifica",
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey[700],
                                  fontSize: 12,
                                  overflow: TextOverflow.ellipsis)
                            ],
                          ),
                        ],
                      ),
                      gapH8,
                      Row(
                        children: [
                          const SizedBox(
                            width: 140,
                            height: 150,
                            child: ImagesWithShadow(
                                image: 'assets/images/menu.png', gap: 0),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    AppText('Precio de venta: ',
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black,
                                        fontSize: 16,
                                        overflow: TextOverflow.ellipsis),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              children: [
                                                Text(
                                                  '17%   ',
                                                  style: theme
                                                      .textTheme.labelMedium!
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.w300,
                                                          fontSize: 15,
                                                          color: Color.fromARGB(
                                                              255,
                                                              206,
                                                              47,
                                                              84)),
                                                ),
                                                Text(
                                                  '5415455465464685',
                                                  style: theme
                                                      .textTheme.labelMedium!
                                                      .copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        AppText('Disponible: ',
                                            fontWeight: FontWeight.normal,
                                            color: Colors.black,
                                            fontSize: 16,
                                            overflow: TextOverflow.ellipsis),
                                        AppText(
                                            '${widget.product.availableUnits}',
                                            fontWeight: FontWeight.normal,
                                            color: Colors.grey[700],
                                            fontSize: 12,
                                            overflow: TextOverflow.ellipsis)
                                      ],
                                    )
                                    /*    Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                              text: 'Disponible: ',
                                              style:
                                                  theme.textTheme.bodyMedium!),
                                          TextSpan(
                                              text: widget
                                                  .product.availableUnits
                                                  .toString(),
                                              style: theme
                                                  .textTheme.labelMedium!
                                                  .copyWith(
                                                fontSize: 14,
                                              ))
                                        ],
                                      ),
                                    ), */
                                    ,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Aplicar descuento: ',
                                            style: theme.textTheme.bodyMedium!),
                                        SizedBox(
                                          width: Screens.width(context) * 0.20,
                                          height: 20,
                                          child: CustomTextEditing(
                                              controller: discountController),
                                        ),
                                        const SizedBox()
                                      ],
                                    ),
                                    gapH8,
                                    Row(
                                      children: [
                                        Text('Cantidad:  ',
                                            style: theme.textTheme.bodyMedium!),
                                        Expanded(
                                            child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                reducirCantidad();
                                              },
                                              child: Material(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        Const.radius),
                                                elevation: Const.elevation,
                                                color:
                                                    theme.colorScheme.secondary,
                                                child: SizedBox(
                                                    height: 30,
                                                    width: 30,
                                                    child: Icon(Icons.remove,
                                                        color: theme.colorScheme
                                                            .onSecondary)),
                                              ),
                                            ),
                                            gapW4,
                                            Text(
                                              '$cantidad',
                                              style: const TextStyle(
                                                  fontSize: 18.0,
                                                  color: Colors.black),
                                            ),
                                            gapW4,
                                            InkWell(
                                              onTap: () {
                                                aumentarCantidad();
                                              },
                                              child: Material(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        Const.radius),
                                                elevation: Const.elevation,
                                                color: theme.primaryColor,
                                                child: SizedBox(
                                                    height: 30,
                                                    width: 30,
                                                    child: Icon(Icons.add,
                                                        color: theme.colorScheme
                                                            .onPrimary)),
                                              ),
                                            ),
                                          ],
                                        )),
                                      ],
                                    ),
                                    ExpandedSection(
                                        expand: expand,
                                        height: 100,
                                        child: const Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('Some Info'),
                                            Text('Some Info 2'),
                                            Text('Some Info 3'),
                                          ],
                                        )),
                                    gapH28
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  )
                ]),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
