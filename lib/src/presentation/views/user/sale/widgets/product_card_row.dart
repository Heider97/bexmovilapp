import 'package:bexmovil/src/domain/models/porduct.dart';
import 'package:bexmovil/src/presentation/widgets/user/image_with_shadow.dart';
import 'package:bexmovil/src/utils/constants/gaps.dart';
import 'package:bexmovil/src/utils/constants/screens.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ProductCardRow extends StatelessWidget {
  final Product firstProduct;
  final Product? secondProduct;
  const ProductCardRow(
      {super.key, required this.firstProduct, required this.secondProduct});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Row(
      children: [
        Expanded(
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  //width: 300,
                  height: Screens.height(context) * 0.25,
                  child: Card(
                    surfaceTintColor: Colors.white,
                    elevation: 5, // Controla la sombra de la tarjeta
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          5.0), // Controla la redondez de las esquinas
                      side: BorderSide(
                          color: theme.primaryColor,
                          width: 1.0), // Controla el borde de la tarjeta
                    ),
                    child: const Column(
                      children: [
                        gapH12,
                        Expanded(
                            child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: ImagesWithShadow(
                            image: 'assets/images/menu.png',
                            gap: 0,
                            heightShadow: 30,
                          ),
                        )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Código: ',
                              style: TextStyle(fontSize: 15),
                            ),
                            Text(
                              'NISHJD84',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        gapH12
                      ],
                    ),
                  ))),
        ),
        gapW12,
        (secondProduct != null)
            ? Expanded(
                child: Padding(
                    padding: const EdgeInsets.only(top: 8, right: 8, bottom: 8),
                    child: Container(
                        //width: 300,
                        height: Screens.height(context) * 0.2,
                        child: Card(
                          surfaceTintColor: Colors.white,
                          elevation: 5,
                          // Controla la sombra de la tarjeta
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                5.0), // Controla la redondez de las esquinas
                            side: BorderSide(
                                color: theme.primaryColor,
                                width: 1.0), // Controla el borde de la tarjeta
                          ),
                          child: const Column(
                            children: [
                              gapH12,
                              Expanded(
                                  child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: ImagesWithShadow(
                                  image: 'assets/images/menu.png',
                                  gap: 0,
                                  heightShadow: 30,
                                ),
                              )),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Código: ',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  Text(
                                    'NISHJD84',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              gapH12
                            ],
                          ),
                        ))),
              )
            : Expanded(
                child: SizedBox(),
              ),
      ],
    );
  }
}
