import 'package:bexmovil/src/domain/models/item_ammount.dart';
import 'package:bexmovil/src/presentation/widgets/user/ammount.dart';
import 'package:bexmovil/src/presentation/widgets/user/image_with_shadow.dart';

import 'package:bexmovil/src/utils/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProductAmmount extends StatelessWidget {
  final ItemAmount product;
  const ProductAmmount({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(Const.padding),
          child: Stack(
            children: [
              Material(
                elevation: 10,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  height: 140,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: const Color(0xFFFEAD1D),
                      borderRadius: BorderRadiusDirectional.circular(20)),
                ),
              ),
              Slidable(
                endActionPane: ActionPane(
                  motion: const BehindMotion(),
                  extentRatio: 0.15,
                  children: [
                    Expanded(
                        child: Container(
                      decoration: BoxDecoration(
                          color: const Color(0xFFFEAD1D),
                          borderRadius: BorderRadius.circular(20)),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: Const.padding),
                            child: Icon(
                              FontAwesomeIcons.trashCan,
                              color: Colors.white,
                              size: 28,
                            ),
                          )
                        ],
                      ),
                      /* child:  */
                    ))
                  ],
                ),
                child: Container(
                    height: 140,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(Const.padding),
                          child: SizedBox(
                            width: 80,
                            height: 100,
                            child: ImagesWithShadow(
                              image: product.image,
                              gap: 0,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(Const.padding),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text.rich(
                                  TextSpan(
                                    text: product.title,
                                    style:
                                        theme.textTheme.labelMedium!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                                Text(
                                  product.weight,
                                  style: theme.textTheme.bodySmall!.copyWith(
                                    color: theme.disabledColor,
                                    fontSize: 16,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text.rich(
                                      TextSpan(
                                        text:
                                            '\$ ${product.price.toStringAsFixed(2)}',
                                        style: theme.textTheme.labelMedium!
                                            .copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: theme.primaryColor,
                                        ),
                                      ),
                                    ),
                                    const Expanded(child: Ammount()),
                                  ],
                                ),
                                Text(
                                  'Descuento ${product.discount} %',
                                  style:
                                      const TextStyle(color: Color(0xFFCC0C39)),
                                ),
                                Text('Lugar de Origen: ${product.origin}'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
