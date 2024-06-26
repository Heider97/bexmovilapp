import 'package:bexmovil/src/domain/models/product.dart';
import 'package:bexmovil/src/presentation/widgets/atoms/app_text.dart';
import 'package:bexmovil/src/presentation/widgets/user/ammount.dart';

import 'package:bexmovil/src/presentation/widgets/user/custom_paint.dart';
import 'package:bexmovil/src/presentation/widgets/user/custom_text_editing.dart';
import 'package:bexmovil/src/presentation/widgets/user/expanded_section.dart';
import 'package:bexmovil/src/presentation/widgets/user/image_with_shadow.dart';
import 'package:bexmovil/src/utils/constants/gaps.dart';
import 'package:bexmovil/src/utils/constants/screens.dart';
import 'package:bexmovil/src/utils/constants/strings.dart';
import 'package:bexmovil/src/utils/extensions/date_time_extension.dart';
import 'package:bexmovil/src/utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';

import '../atomsbox.dart';

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
  TextEditingController ammountController = TextEditingController();

  @override
  void initState() {
    //  cantidad = widget.product.quantity;
    super.initState();
  }

  void reducirCantidad() {
    /*  if (cantidad > 0) {
      setState(() {
        widget.product.quantity--;
        cantidad--;
        widget.refresh();
      });
    } */
  }

  void aumentarCantidad() {
    /*    if (cantidad < widget.product.availableUnits) {
      setState(() {
        widget.product.quantity++;
        cantidad++;
        widget.refresh();
      });
    } */
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
              left: Const.padding, bottom: Const.padding, right: Const.padding),
          child: CustomPaint(
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
                  AppCardImageAndContentBlock(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppTextBlock(
                            title:
                                AppText('Última fecha vendida', fontSize: 14),
                            subtitle: AppText('2024/08/20')),
                        AppTextBlock(
                            title: AppText('Última cantidad vendida',
                                fontSize: 14),
                            subtitle: AppText('100')),
                      ],
                    ),
                    headline: AppText(
                      'Código: ${widget.product.codProducto!}',
                      fontSize: 16,
                    ),
                    subhead: widget.product.nomProducto,
                    // image: AppImage.asset('assets/images/menu.png'),
                    contents: [
                      AppText(
                          'Precio: ${''.formatted(widget.product.precioProductoPrecio?.toDouble() ?? 0.0)}'),
                      AppText('Disponible: ${widget.product.existenciaStock}'),
                    ],
                    subContents: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Aplicar descuento: ',
                            style: theme.textTheme.bodyMedium!
                                .copyWith(fontSize: 14),
                          ),
                          SizedBox(
                            width: Screens.width(context) * 0.20,
                            height: 20,
                            child: CustomTextEditing(
                                controller: discountController),
                          ),
                          const SizedBox()
                        ],
                      ),
                    /*   Row(
                        children: [
                          AppText('Cantidad:  '),
                          Ammount(
                            controller: ammountController,
                          )
                        ],
                      ), */
                      ExpandedSection(
                          expand: expand,
                          height: 100,
                          child: const Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Some Info'),
                              Text('Some Info 2'),
                              Text('Some Info 3'),
                            ],
                          )),
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
