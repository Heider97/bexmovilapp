import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//domain
import '../../../../../domain/models/price.dart';
//cubit
import '../../../../blocs/sale/sale_bloc.dart';
//widgets
import '../../../../widgets/atomsbox.dart';

class SalePrices extends StatelessWidget {
  final List<Price>? prices;

  const SalePrices({super.key, required this.prices});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<SaleBloc, SaleState>(builder: (context, state) {
        if (prices != null &&
            prices!.isNotEmpty == true) {
          return ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: prices?.length,
              itemBuilder: (context, index) {
                return AppText(prices![index].nomprecio ?? "N/A");
              });
        } else {
          return AppText('No hay precios disponibles');
        }
      }),
    );
  }
}
