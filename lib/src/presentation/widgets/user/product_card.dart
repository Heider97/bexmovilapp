import 'package:bexmovil/src/domain/models/porduct.dart';
import 'package:bexmovil/src/presentation/widgets/user/ammount.dart';
import 'package:bexmovil/src/presentation/widgets/user/custom_paint.dart';
import 'package:bexmovil/src/presentation/widgets/user/custom_text_editing.dart';
import 'package:bexmovil/src/presentation/widgets/user/expanded_section.dart';
import 'package:bexmovil/src/presentation/widgets/user/image_with_shadow.dart';
import 'package:bexmovil/src/utils/constants/gaps.dart';
import 'package:bexmovil/src/utils/constants/screens.dart';
import 'package:bexmovil/src/utils/constants/strings.dart';
import 'package:bexmovil/src/utils/extensions/date_time_extenstion.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatefulWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool expand = true;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Column(
      children: [
        Padding(
          padding:
              const EdgeInsets.only(left: Const.padding, right: Const.padding),
          child: CustomPaint(
            //size: Size(200, 400),
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
                      Column(
                        children: [
                          gapH4,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Ultima vez el: ',
                                      style: theme.textTheme.labelMedium,
                                    ),
                                    TextSpan(
                                        text: widget.product.lastSoldOn
                                                ?.formatTime() ??
                                            "No especifica",
                                        style: theme.textTheme.labelMedium)
                                  ],
                                ),
                              ),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Ultima cantidad vendida: ',
                                      style: theme.textTheme.labelMedium,
                                    ),
                                    TextSpan(
                                        text:
                                            '${widget.product.lastQuantitySold ?? 'No especifica'}',
                                        style: theme.textTheme.labelMedium)
                                  ],
                                ),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(
                                                  text: 'Código: ',
                                                  style: theme
                                                      .textTheme.labelMedium!),
                                              TextSpan(
                                                  text: widget.product.code,
                                                  style: theme
                                                      .textTheme.labelMedium!
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15))
                                            ],
                                          ),
                                        ),
                                        Text(widget.product.name,
                                            style: theme.textTheme.titleMedium!
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                        Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(
                                                  text: 'Precio de venta: ',
                                                  style: theme
                                                      .textTheme.labelMedium!),
                                              TextSpan(
                                                  text:
                                                      '\n-${widget.product.discount.toInt()}%',
                                                  style: theme
                                                      .textTheme.labelMedium!
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15,
                                                          color: const Color(
                                                              0xFFCC0C39))),
                                              TextSpan(
                                                  text:
                                                      '\$ ${widget.product.sellingPrice.toDouble()}00000000',
                                                  style: theme
                                                      .textTheme.labelMedium!
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15,
                                                          color: theme
                                                              .primaryColor))
                                            ],
                                          ),
                                        ),
                                        Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(
                                                  text: 'Disponible: ',
                                                  style: theme
                                                      .textTheme.labelMedium!),
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
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Aplicar descuento',
                                                style: theme
                                                    .textTheme.labelMedium!),
                                            SizedBox(
                                              width:
                                                  Screens.width(context) * 0.20,
                                              height: 20,
                                              child: CustomTextEditing(
                                                controller:
                                                    TextEditingController(),
                                              ),
                                            ),
                                            SizedBox()
                                          ],
                                        ),
                                        gapH4,
                                        Row(
                                          children: [
                                            Text('Cantidad:  ',
                                                style: theme
                                                    .textTheme.labelMedium!),
                                            const Expanded(child: Ammount()),
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
