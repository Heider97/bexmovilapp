import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/sale/sale_bloc.dart';
import '../widgets/card_router_sale.dart';

class SaleRouters extends StatelessWidget {
  const SaleRouters({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SaleBloc, SaleState>(builder: (context, state) {
      if (state.status == SaleStatus.success && state.routers != null) {
        return Expanded(
          child: ListView.builder(
              itemCount: state.routers?.length,
              itemBuilder: (context, index) {
                return CardRouter(
                  codeRouter: state.routers![index].dayRouter!,
                  quantityClients:
                      state.routers![index].quantityClient.toString(),
                  dayRouter: state.routers![index].nameDayRouter.toString(),
                  totalClients: state.routers![index].quantityClient,
                );
              }),
        );
      } else {
        return const Center(child: Text('Cargando'));
      }
    });
  }
}
