import 'package:bexmovil/src/domain/models/item_ammount.dart';
import 'package:bexmovil/src/domain/models/product.dart';
import 'package:bexmovil/src/domain/repositories/database_repository.dart';
import 'package:bexmovil/src/locator.dart';
import 'package:bexmovil/src/presentation/blocs/sale/sale_bloc.dart';
import 'package:bexmovil/src/presentation/widgets/atoms/app_text.dart';
import 'package:bexmovil/src/presentation/widgets/user/ammount.dart';
import 'package:bexmovil/src/presentation/widgets/user/image_with_shadow.dart';
import 'package:bexmovil/src/utils/constants/gaps.dart';
import 'package:bexmovil/src/utils/constants/screens.dart';

import 'package:bexmovil/src/utils/constants/strings.dart';
import 'package:bexmovil/src/utils/extensions/string_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final DatabaseRepository _databaseRepository = locator<DatabaseRepository>();

class ProductAmmount extends StatefulWidget {
  final ProductCart product;

  const ProductAmmount({super.key, required this.product});

  @override
  State<ProductAmmount> createState() => _ProductAmmountState();
}

class _ProductAmmountState extends State<ProductAmmount> {
  late SaleBloc saleBloc;

  @override
  void initState() {
    saleBloc = BlocProvider.of<SaleBloc>(context);
    super.initState();
  }

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
              BlocBuilder<SaleBloc, SaleState>(
                builder: (context, state) {
                  return Slidable(
                    endActionPane: ActionPane(
                      motion: const BehindMotion(),
                      extentRatio: 0.15,
                      children: [
                        Expanded(
                            child: Container(
                          decoration: const BoxDecoration(
                              color: Color(0xFFFEAD1D),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: InkWell(
                            onTap: () async {
                              saleBloc.add(RemoveItemCart(
                                  codProduct:
                                      widget.product.product.codProducto!));
                            },
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.only(right: Const.padding),
                                  child: Icon(
                                    FontAwesomeIcons.trashCan,
                                    color: Colors.white,
                                    size: 28,
                                  ),
                                )
                              ],
                            ),
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
                            (widget.product.product.imagen != null)
                                ? SizedBox(
                                    width: 100,
                                    height: Screens.height(context) * 0.15,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ImagesWithShadow(
                                        image: widget.product.product.imagen!,
                                        gap: 0,
                                      ),
                                    ),
                                  )
                                : SizedBox(),
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
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    gapW12,
                                                    Row(
                                                      children: [
                                                        Opacity(
                                                          opacity: 0.8,
                                                          child: AppText(
                                                              'Código: ',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              /*  color: theme
                                                                            .primaryColor, */
                                                              fontSize: 12,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis),
                                                        ),
                                                        AppText('${widget.product.product.codProducto}',
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.black,
                                                            fontSize: 12,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis),
                                                      ],
                                                    ),
                                                    AppText(
                                                        widget.product.product
                                                            .nomProducto,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.black,
                                                        fontSize: 16,
                                                        overflow: TextOverflow
                                                            .ellipsis),
                                                  ],
                                                ),
                                              ),
                                            ])),
                                    Row(
                                      children: [
                                        /* Text(
                                                    '- ${product} ',
                                                    style: const TextStyle(
                                                        color:
                                                            Color.fromARGB(255, 219, 8, 57)),
                                                  ), */
                                        Text.rich(
                                          TextSpan(
                                            text: ''.formatted(widget
                                                    .product
                                                    .product
                                                    .precioProductoPrecio ??
                                                0),
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
                                        Ammount(
                                            codeProduct: widget
                                                .product.product.codProducto!,
                                            controller: TextEditingController(
                                                text: widget.product.stock
                                                    .toString()))
                                      ],
                                    )

                                    //    const Expanded(child: Ammount()),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
