import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//domain
import '../../../../../domain/models/price.dart';
//cubit
import '../../../../../utils/constants/screens.dart';
import '../../../../blocs/sale/sale_bloc.dart';
//widgets
import '../../../../widgets/atomsbox.dart';

class SalePrices extends StatelessWidget {
  final List<Price>? prices;

  const SalePrices({super.key, required this.prices});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<SaleBloc, SaleState>(builder: (context, state) {
        ScrollController scrollController = ScrollController();

        if (prices != null && prices!.isNotEmpty == true) {
          return SizedBox(
            height: Screens.height(context) * 0.40,
            child: RawScrollbar(
              thumbVisibility: true,
              thumbColor: theme.primaryColor,
              thickness: 3,
              controller: scrollController,
              child: ListView.builder(
                controller: scrollController,
                itemCount: prices!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      // setState(() {
                      //   _selectedRadioBodega =
                      //       index; // Actualiza el valor seleccionado
                      // });
                    },
                    selected: false,
                    title: AppText(prices![index].nomprecio!),
                    trailing: Radio(
                      value: index,
                      groupValue: '0',
                      onChanged: (value) {
                        // setState(() {
                        //   _selectedRadioBodega = value
                        //   as int; // Actualiza el valor seleccionado
                        // });
                      },
                    ),
                  );
                },
              ),
            ),
          );
        } else {
          return AppText('No hay precios disponibles');
        }
      }),
    );
  }
}
