import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

class ClientItemsAlert extends StatefulWidget {
  const ClientItemsAlert({super.key});

  @override
  State<ClientItemsAlert> createState() => _ClientItemsAlertState();
}

class _ClientItemsAlertState extends State<ClientItemsAlert> {
  TextEditingController textController = TextEditingController();
  Color primaryColor = Color(0xFFF27114);
  String inputValue = '';
  String dropdownValue = 'Bodega 1';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Dialog(
          insetPadding: EdgeInsets.zero,
          surfaceTintColor: Colors.white,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          child: SizedBox(
            child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 2,
                          child: Text(
                            'Tubo EMT 2" IMP NAL - Oa Super Promo',
                            maxLines: 2,
                            softWrap:
                                true, // Permite que el texto se envuelva si supera el límite de una línea
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: 18,
                            ),
                            overflow: TextOverflow
                                .ellipsis, // Trunca el texto si supera las dos líneas
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.grey[200],
                            child: Icon(
                              Icons.close,
                              color: Colors.black,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Código: 001-687761NA2'),
                        Text('Unidad de venta: Libra/L '),
                      ],
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Divider(
                      color: Colors.grey[300],
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Precio de última venta: 60.000.000'),
                      ],
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Divider(
                      color: Colors.grey[300],
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('IVA: 19%'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text('Precio: 50.000.000'),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.edit,
                                  color: primaryColor,
                                  size: 14,
                                ),
                              ],
                            ),
                          ],
                        ),
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
                                                      const EdgeInsets
                                                          .symmetric(
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
                                                      color:
                                                          (inputValue.isEmpty)
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
                      ],
                    ),
                    Divider(
                      color: Colors.grey[300],
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Peso: 1.000 g'),
                            Text('Unidad Embalaje: 50 KG'),
                            DropdownButton<String>(
                              elevation: 0,
                              value: dropdownValue,
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color: primaryColor,
                              ),
                              iconSize: 24,
                              borderRadius: BorderRadius.circular(5),
                              onChanged: (newValue) {
                                setState(() {
                                  dropdownValue = newValue!;
                                });
                              },
                              items: <String>[
                                'Bodega 1',
                                'Bodega 2',
                                'Bodega 3',
                                'Bodega 4'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium!,
                                  ),
                                );
                              }).toList(),
                            )
                          ],
                        ),
                        Container(
                          //color: Colors.red,
                          width: 200,
                          height: 80,
                          child: SfBarcodeGenerator(
                            value: '154987',
                            //symbology: QRCode(),
                            showValue: true,
                          ),
                        )
                      ],
                    ),
                  ],
                )),
          )),
    );
  }
}
