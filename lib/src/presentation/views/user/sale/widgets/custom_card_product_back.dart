import 'package:bexmovil/src/domain/models/product.dart';
import 'package:bexmovil/src/utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';

class CustomCardProductBack extends StatefulWidget {
  final Product product;
  const CustomCardProductBack({super.key, required this.product});

  @override
  State<CustomCardProductBack> createState() => __CustomCardProducStateState();
}

class __CustomCardProducStateState extends State<CustomCardProductBack> {
  TextEditingController textController = TextEditingController();
  Color primaryColor = Color(0xFFF27114);
  String inputValue = '';

  @override
  Widget build(BuildContext context) {
     ThemeData theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        onTap: () {},
        child: Material(
          elevation: 1,
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                          Expanded(
                        flex: 1,
                        child: Text(
                          widget.product.nomProducto
                                  .toLowerCase()
                                  .capitalizeString() ??
                              'N/A',
                          maxLines: 2,
                          softWrap:
                              true, // Permite que el texto se envuelva si supera el límite de una línea
                          style: theme.textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            fontSize: 17,
                          ),
                          overflow: TextOverflow
                              .ellipsis, // Trunca el texto si supera las dos líneas
                        ),
                      ),
                          Row(
                        children: [
                          SizedBox(width: 20,),
                          Text(
                            'Código: \n${widget.product.codProducto}',
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              
                              fontSize: 12,
                            ),
                            overflow:
                                TextOverflow.visible, // Cambiado overflow a visible
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Vendido por última vez:\n24/05/2023'),
                      Text('Última cantidad vendida:\n 50'),
                    ],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Column(
                            children: [
                              Text('Descuento: '),
                              SizedBox(
                                height: 20,
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 40,
                                width: 120,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
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
                                      //TEXTFIELD

                                      Expanded(
                                          child: TextFormField(
                                              onChanged: (value) {
                                                inputValue = value;
                                                setState(() {});
                                              },
                                              controller: textController,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: InputDecoration(
                                                focusColor: primaryColor,
                                                filled: true,
                                                fillColor: Colors.white,
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                  //  vertical: Const.space5,
                                                  vertical: 1,
                                                  horizontal: 5,
                                                ),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0), // Ajusta el radio para cambiar la cantidad de redondez
                                                  borderSide: BorderSide
                                                      .none, // Puedes establecer un borde si lo deseas
                                                ),
                                              ))),
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Opacity(
                                          opacity: 0.75,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(3),
                                              color: (inputValue.isEmpty)
                                                  ? Colors.grey[200]
                                                  : primaryColor,
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(6.0),
                                              child: Text(
                                                'Aplicar',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: (inputValue.isEmpty)
                                                        ? Colors.grey[400]
                                                        : Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ]),
                              ),
                              Text(
                                'Hasta 30 %',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.grey[400]),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        width: 18,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Lugar de origen: \nMedellin'),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
