import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//domain
import '../../../../../domain/models/warehouse.dart';
//cubit
import '../../../../blocs/sale/sale_bloc.dart';
//widgets
import '../../../../widgets/atomsbox.dart';

class SaleWarehouses extends StatelessWidget {
  final List<Warehouse>? warehouses;

  const SaleWarehouses({super.key, required this.warehouses});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<SaleBloc, SaleState>(builder: (context, state) {
        if (warehouses != null &&
            warehouses!.isNotEmpty == true) {
          return ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: warehouses?.length,
              itemBuilder: (context, index) {
                return AppText(warehouses![index].nombodega ?? "N/A");
              });
        } else {
          return AppText('No hay bodegas disponibles');
        }
      }),
    );
  }
}
