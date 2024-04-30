import 'package:bexmovil/src/locator.dart';
import 'package:bexmovil/src/presentation/widgets/atoms/app_text.dart';
import 'package:bexmovil/src/services/navigation.dart';
import 'package:bexmovil/src/utils/constants/gaps.dart';
import 'package:bexmovil/src/utils/constants/screens.dart';
import 'package:bexmovil/src/utils/constants/strings.dart';
import 'package:flutter/material.dart';

final NavigationService _navigationService = locator<NavigationService>();

class ShowPriceAndWarehousesAlert extends StatefulWidget {
  const ShowPriceAndWarehousesAlert({
    super.key,
  });

  @override
  State<ShowPriceAndWarehousesAlert> createState() =>
      _ShowPriceAndWarehousesAlertState();
}

class _ShowPriceAndWarehousesAlertState
    extends State<ShowPriceAndWarehousesAlert> {
  ScrollController scrollController = ScrollController();
  ScrollController scrollController2 = ScrollController();

  int _selectedRadioBodega = -1;
  int _selectedRadioListaPrecios = -1;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Dialog(
      surfaceTintColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText('Bodega', fontSize: 16, fontWeight: FontWeight.bold),
              gapH8,
              const Text(
                  'Selecciona la bodega de la cual saldran los articulos a vender.'),
              gapH20,
              Container(
                height: Screens.height(context) * 0.17,
                color: Colors.grey[50],
                child: RawScrollbar(
                  thumbVisibility: true,
                  thumbColor: theme.primaryColor,
                  thickness: 3,
                  controller: scrollController,
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          setState(() {
                            _selectedRadioBodega =
                                index; // Actualiza el valor seleccionado
                          });
                        },
                        selected: false,
                        title: Text('Nombre bodega'),
                        subtitle: Text(
                          'Ubicacion Bodega',
                          style: theme.textTheme.bodyMedium!
                              .copyWith(color: theme.disabledColor),
                        ),
                        trailing: Radio(
                          value: index,
                          groupValue: _selectedRadioBodega,
                          onChanged: (value) {
                            setState(() {
                              _selectedRadioBodega = value
                                  as int; // Actualiza el valor seleccionado
                            });
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
              gapH20,
              AppText('Lista de precios',
                  fontSize: 16, fontWeight: FontWeight.bold),
              gapH8,
              const Text(
                  'Escoge la lista de precios para aplicar al cliente seleccionado.'),
              gapH20,
              Container(
                height: Screens.height(context) * 0.15,
                color: Colors.grey[50],
                child: RawScrollbar(
                  thumbVisibility: true,
                  thumbColor: theme.primaryColor,
                  thickness: 3,
                  controller: scrollController2,
                  radius: const Radius.circular(5),
                  child: ListView.builder(
                    controller: scrollController2,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          setState(() {
                            _selectedRadioListaPrecios =
                                index; // Actualiza el valor seleccionado
                          });
                        },
                        selected: false,
                        title: Text('Nombre lista de precios'),
                        subtitle: Text(
                          'Código Lista de precios',
                          style: theme.textTheme.bodyMedium!
                              .copyWith(color: theme.disabledColor),
                        ),
                        trailing: Radio(
                          value: index,
                          groupValue: _selectedRadioListaPrecios,
                          onChanged: (value) {
                            setState(() {
                              _selectedRadioListaPrecios = value
                                  as int; // Actualiza el valor seleccionado
                            });
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
              gapH20,
              InkWell(
                onTap: () {
                  if (_selectedRadioBodega != -1 &&
                      _selectedRadioListaPrecios != -1) {
                    _navigationService.goTo(AppRoutes.selectProducts);
                  } else {
                    // Muestra algún tipo de mensaje de advertencia o realiza otra acción según tus necesidades
                  }
                },
                child: SizedBox(
                  height: 40,
                  child: Opacity(
                    opacity: (_selectedRadioBodega != -1 &&
                            _selectedRadioListaPrecios != -1)
                        ? 1
                        : 0.5,
                    child: Material(
                      color: theme.primaryColor,
                      borderRadius: BorderRadius.circular(10),
                      elevation: 5,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15.0, right: 15),
                          child: Text(
                            'Confirmar',
                            style: theme.textTheme.bodyMedium!.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ]),
      ),
    );
  }
}
