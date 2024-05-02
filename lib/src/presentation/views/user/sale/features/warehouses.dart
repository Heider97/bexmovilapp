import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//domain
import '../../../../../domain/models/warehouse.dart';
//cubit
import '../../../../../utils/constants/screens.dart';
import '../../../../blocs/sale/sale_bloc.dart';
//widgets
import '../../../../widgets/atomsbox.dart';

class SaleWarehouses extends StatelessWidget {
  final List<Warehouse>? warehouses;

  const SaleWarehouses({super.key, required this.warehouses});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    ScrollController scrollController = ScrollController();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<SaleBloc, SaleState>(builder: (context, state) {
        if (warehouses != null && warehouses!.isNotEmpty == true) {
          return Container(
            height: Screens.height(context) * 0.30,
            color: Colors.grey[50],
            child: RawScrollbar(
              thumbVisibility: true,
              thumbColor: theme.primaryColor,
              thickness: 3,
              controller: scrollController,
              child: ListView.builder(
                controller: scrollController,
                itemCount: warehouses!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      // setState(() {
                      //   _selectedRadioBodega =
                      //       index; // Actualiza el valor seleccionado
                      // });
                    },
                    selected: false,
                    title: AppText(warehouses![index].nombodega!),
                    subtitle: Text(
                      'Ubicacion Bodega',
                      style: theme.textTheme.bodyMedium!
                          .copyWith(color: theme.disabledColor),
                    ),
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
          return AppText('No hay bodegas disponibles');
        }
      }),
    );
  }
}
