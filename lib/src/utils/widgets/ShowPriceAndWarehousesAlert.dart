import 'package:bexmovil/src/domain/models/arguments.dart';
import 'package:bexmovil/src/locator.dart';
import 'package:bexmovil/src/presentation/blocs/sale/sale_bloc.dart';
import 'package:bexmovil/src/presentation/widgets/atoms/app_text.dart';
import 'package:bexmovil/src/services/navigation.dart';
import 'package:bexmovil/src/utils/constants/gaps.dart';
import 'package:bexmovil/src/utils/constants/screens.dart';
import 'package:bexmovil/src/utils/constants/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final NavigationService navigationService = locator<NavigationService>();

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

  late SaleBloc saleBloc;

  int _selectedRadioBodega = -1;
  int _selectedRadioListaPrecios = -1;

  @override
  void initState() {
    saleBloc = BlocProvider.of<SaleBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return BlocBuilder<SaleBloc, SaleState>(builder: (context, state) {
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
                Opacity(
                  opacity: (_selectedRadioBodega != -1 &&
                          _selectedRadioListaPrecios != -1)
                      ? 1
                      : 0.5,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue,
                    ),
                    width: Screens.width(context),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        state.selectedClient!.name!,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyMedium!
                            .copyWith(color: theme.colorScheme.onPrimary),
                      ),
                    ),
                  ),
                ),
                gapH16,
                AppText('Bodega', fontSize: 16, fontWeight: FontWeight.bold),
                gapH8,
                const Text(
                    'Selecciona la bodega de la cual saldran los articulos a vender.'),
                gapH20,
                BlocBuilder<SaleBloc, SaleState>(builder: (context, state) {
                  return Container(
                      height: Screens.height(context) * 0.17,
                      color: Colors.grey[50],
                      child: (state.warehouseList != null)
                          ? RawScrollbar(
                              thumbVisibility: true,
                              thumbColor: theme.primaryColor,
                              thickness: 3,
                              controller: scrollController,
                              child: ListView.builder(
                                controller: scrollController,
                                itemCount: state.warehouseList!.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    onTap: () {
                                      saleBloc.add(SelectWarehouse(
                                          warehouse:
                                              state.warehouseList![index]));
                                      setState(() {
                                        _selectedRadioBodega =
                                            index; // Actualiza el valor seleccionado
                                      });
                                    },
                                    selected: false,
                                    title: Text(
                                        state.warehouseList![index].nombodega ??
                                            'N/A'),
                                    subtitle: Text(
                                      state.warehouseList![index].codbodega ??
                                          'N/A',
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
                              ))
                          : Center(
                              child: (state.status == SaleStatus.loading)
                                  ? const CircularProgressIndicator()
                                  : const Text('No hay bodegas disponibles.')));
                }),
                gapH20,
                AppText('Lista de precios',
                    fontSize: 16, fontWeight: FontWeight.bold),
                gapH8,
                const Text(
                    'Escoge la lista de precios para aplicar al cliente seleccionado.'),
                gapH20,
                BlocBuilder<SaleBloc, SaleState>(builder: (context, state) {
                  return Container(
                    height: Screens.height(context) * 0.15,
                    color: Colors.grey[50],
                    child: (state.priceList != null)
                        ? RawScrollbar(
                            thumbVisibility: true,
                            thumbColor: theme.primaryColor,
                            thickness: 3,
                            controller: scrollController2,
                            radius: const Radius.circular(5),
                            child: ListView.builder(
                              controller: scrollController2,
                              itemCount: state.priceList!.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  onTap: () {
                                    saleBloc.add(SelectPriceList(
                                        listPriceSelected:
                                            state.priceList![index]));
                                    setState(() {
                                      _selectedRadioListaPrecios = index;
                                    });
                                  },
                                  selected: false,
                                  title: Text(
                                      state.priceList?[index].nomprecio ??
                                          'N/A'),
                                  subtitle: Text(
                                    state.priceList?[index].codprecio ?? 'N/A',
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
                          )
                        : Center(
                            child: (state.status == SaleStatus.loading)
                                ? const CircularProgressIndicator()
                                : const Text(
                                    'No hay listado de precios disponible'),
                          ),
                  );
                }),
                gapH20,
                BlocBuilder<SaleBloc, SaleState>(builder: (context, state) {
                  return InkWell(
                    onTap: () {
                      if (_selectedRadioBodega != -1 &&
                          _selectedRadioListaPrecios != -1) {
                        navigationService.goTo(AppRoutes.productsSale,
                            arguments: ProductArgument(
                                codcliente: state.selectedClient!.id!,
                                codbodega: state
                                    .warehouseList![_selectedRadioBodega]
                                    .codbodega!,
                                codprecio: state
                                    .priceList![_selectedRadioListaPrecios]
                                    .codprecio!));
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
                              padding:
                                  const EdgeInsets.only(left: 15.0, right: 15),
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
                  );
                }),
              ]),
        ),
      );
    });
  }
}
