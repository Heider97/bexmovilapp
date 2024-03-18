import 'package:flutter/cupertino.dart' hide Router;
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../domain/models/router.dart';
import '../../../../blocs/sale/sale_bloc.dart';
import '../widgets/card_router_sale.dart';

class SaleRouters extends StatelessWidget {

  final List<Router>? routers;

  const SaleRouters({super.key, this.routers });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SaleBloc, SaleState>(builder: (context, state) {
      if (state.status == SaleStatus.success && routers != null) {
        return Expanded(
          child: ListView.builder(
              itemCount: routers?.length,
              itemBuilder: (context, index) {
                return CardRouter(
                  codeRouter: routers![index].dayRouter!,
                  quantityClients: routers![index].quantityClient.toString(),
                  dayRouter: routers![index].nameDayRouter.toString(),
                  totalClients: routers![index].quantityClient,
                );
              }),
        );
      } else {
        return const Center(child: Text('Cargando'));
      }
    });
  }
}
