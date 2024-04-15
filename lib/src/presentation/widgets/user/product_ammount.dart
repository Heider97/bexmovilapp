import 'package:bexmovil/src/domain/models/item_ammount.dart';
import 'package:bexmovil/src/presentation/widgets/atoms/app_text.dart';
import 'package:bexmovil/src/presentation/widgets/user/ammount.dart';
import 'package:bexmovil/src/presentation/widgets/user/image_with_shadow.dart';
import 'package:bexmovil/src/utils/constants/gaps.dart';
import 'package:bexmovil/src/utils/constants/screens.dart';

import 'package:bexmovil/src/utils/constants/strings.dart';
import 'package:flutter/cupertino.dart';
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
          padding:
              const EdgeInsets.only(left: Const.padding, right: Const.padding),
          child: Stack(
            children: [
              Material(
                elevation: 10,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  height: Screens.height(context) * 0.15,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: const Color(0xFFFEAD1D),
                      // color: Colors.red,
                      borderRadius: BorderRadiusDirectional.circular(10)),
                ),
              ),
              Slidable(
                endActionPane: ActionPane(
                  motion: const BehindMotion(),
                  extentRatio: 0.15,
                  children: [
                    Expanded(
                        child: Container(
                      decoration: const BoxDecoration(
                          color: Color(0xFFFEAD1D),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
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
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 100,
                          height: Screens.height(context) * 0.15,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
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
                                SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                gapW12,
                                                Row(
                                                  children: [
                                                    Opacity(
                                                      opacity: 0.8,
                                                      child: AppText('Código: ',
                                                          fontWeight:
                                                              FontWeight.w500,
                                                         /*  color: theme
                                                              .primaryColor, */
                                                          fontSize: 12,
                                                          overflow: TextOverflow
                                                              .ellipsis),
                                                    ),
                                                    AppText(
                                                        'GM1594S',
                                                        fontWeight:
                                                          FontWeight.bold,
                                                        color: Colors.black,
                                                        fontSize: 12,
                                                        overflow: TextOverflow
                                                            .ellipsis),
                                                  ],
                                                ),
                                                AppText(
                                                    'Cerdo Levante 1 Naranga Mega Pro 35% Para Vacas',
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    overflow:
                                                        TextOverflow.ellipsis),
                                              ],
                                            ),
                                          ),
                                        ])),
                                Row(
                                  children: [
                                    Text(
                                      '- ${product.discount} ',
                                      style: const TextStyle(
                                          color:
                                              Color.fromARGB(255, 219, 8, 57)),
                                    ),
                                    Text.rich(
                                      TextSpan(
                                        text:
                                            '\$ ${product.price.toStringAsFixed(2)}',
                                        style: theme.textTheme.labelMedium!
                                            .copyWith(
                                          //fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          // color: theme.primaryColor,
                                        ),
                                      ),
                                    ),
                                    gapW12,
                                  ],
                                ),
                              gapH4,
                                Row(
                                  children: [
                                 /*    AppText('Unidad: ',
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                        fontSize: 13,
                                        overflow: TextOverflow.ellipsis), */
                                    AppText(' 1 KG ',
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey[700],
                                        fontSize: 13,
                                        overflow: TextOverflow.ellipsis),
                                  ],
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    SizedBox(),
                                    Ammount(controller: TextEditingController())
                                  ],
                                )

                                //    const Expanded(child: Ammount()),
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
