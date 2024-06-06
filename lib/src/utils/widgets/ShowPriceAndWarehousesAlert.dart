import 'package:bexmovil/src/domain/models/arguments.dart';
import 'package:bexmovil/src/locator.dart';
import 'package:bexmovil/src/presentation/blocs/sale/sale_bloc.dart';
import 'package:bexmovil/src/presentation/widgets/atoms/app_text.dart';
import 'package:bexmovil/src/services/navigation.dart';
import 'package:bexmovil/src/utils/constants/gaps.dart';
import 'package:bexmovil/src/utils/constants/screens.dart';
import 'package:bexmovil/src/utils/constants/strings.dart';

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
                  opacity: (state.priceSelected != null &&
                          state.warehouseSelected != null)
                      ? 1
                      : 0.5,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue,
                    ),
                    width: Screens.width(context),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AppText(
                        state.client!.name!,
                        textAlign: TextAlign.center,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                gapH16,
                AppText('Bodega', fontSize: 16),
                gapH8,
                AppText(
                    'Selecciona la bodega de la cual saldran los articulos a vender.'),
                gapH20,
                BlocBuilder<SaleBloc, SaleState>(builder: (context, state) {
                  return Container(
                      height: Screens.height(context) * 0.17,
                      color: Colors.grey[50],
                      child: (state.warehouses != null)
                          ? RawScrollbar(
                              thumbVisibility: true,
                              thumbColor: theme.primaryColor,
                              thickness: 3,
                              controller: scrollController,
                              child: ListView.builder(
                                controller: scrollController,
                                itemCount: state.warehouses!.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                      onTap: () {
                                        saleBloc.add(SelectWarehouse(
                                            warehouse:
                                                state.warehouses![index]));
                                      },
                                      selected: false,
                                      title: AppText(
                                        state.warehouses![index].nombodega ??
                                            'N/A',
                                        fontSize: 14,
                                      ),
                                      subtitle: AppText(
                                        state.warehouses![index].codbodega ??
                                            'N/A',
                                        fontSize: 14,
                                      ),
                                      trailing: (state.warehouses![index] ==
                                              state.warehouseSelected)
                                          ? Icon(Icons.radio_button_checked)
                                          : Icon(Icons.radio_button_off));
                                },
                              ))
                          : Center(
                              child: (state.status == SaleStatus.loading)
                                  ? const CircularProgressIndicator()
                                  : AppText('No hay bodegas disponibles.')));
                }),
                gapH20,
                AppText('Lista de precios', fontSize: 16),
                gapH8,
                AppText(
                    'Escoge la lista de precios para aplicar al cliente seleccionado.'),
                gapH20,
                BlocBuilder<SaleBloc, SaleState>(builder: (context, state) {
                  return Container(
                    height: Screens.height(context) * 0.15,
                    color: Colors.grey[50],
                    child: (state.prices != null)
                        ? RawScrollbar(
                            thumbVisibility: true,
                            thumbColor: theme.primaryColor,
                            thickness: 3,
                            controller: scrollController2,
                            radius: const Radius.circular(5),
                            child: ListView.builder(
                              controller: scrollController2,
                              itemCount: state.prices!.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                    onTap: () {
                                      saleBloc.add(SelectPriceList(
                                          listPriceSelected:
                                              state.prices![index]));
                                    },
                                    selected: false,
                                    title: AppText(
                                        state.prices?[index].nomprecio ?? 'N/A',
                                        fontSize: 14),
                                    subtitle: AppText(
                                      state.prices?[index].codprecio ?? 'N/A',
                                      fontSize: 14,
                                    ),
                                    trailing: (state.prices![index] ==
                                            state.priceSelected)
                                        ? Icon(Icons.radio_button_checked)
                                        : Icon(Icons.radio_button_off));
                              },
                            ),
                          )
                        : Center(
                            child: (state.status == SaleStatus.loading)
                                ? const CircularProgressIndicator()
                                : AppText(
                                    'No hay listado de precios disponible'),
                          ),
                  );
                }),
                gapH20,
                BlocBuilder<SaleBloc, SaleState>(builder: (context, state) {
                  return InkWell(
                    onTap: () {
                      if (state.priceSelected != null &&
                          state.warehouseSelected != null) {
                        navigationService.goTo(AppRoutes.productsSale,
                            arguments: ProductArgument(
                                client: state.client!,
                                codbodega: state.warehouseSelected!.codbodega!,
                                codprecio: state.priceSelected!.codprecio!));

                               
                      }

                      /*     if (_selectedRadioBodega != -1 &&
                          _selectedRadioListaPrecios != -1) {
                        navigationService.goTo(AppRoutes.productsSale,
                            arguments: ProductArgument(
                                client: state.client!,
                                codbodega: state
                                    .warehouses![_selectedRadioBodega]
                                    .codbodega!,
                                codprecio: state
                                    .prices![_selectedRadioListaPrecios]
                                    .codprecio!));
                      } else {
                        // Muestra algún tipo de mensaje de advertencia o realiza otra acción 
                      } */
                    },
                    child: SizedBox(
                      height: 40,
                      child: Opacity(
                        opacity: (state.priceSelected != null &&
                                state.warehouseSelected != null)
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
                              child: AppText.bodyMedium(
                                'Confirmar',
                                color: Colors.white,
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
