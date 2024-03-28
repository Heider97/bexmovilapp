import 'package:bexmovil/src/presentation/views/user/sale/widgets/card_router_sale.dart';
import 'package:bexmovil/src/presentation/widgets/atoms/app_text.dart';
import 'package:flutter/cupertino.dart' hide Router;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../domain/models/router.dart' as router;
import '../../../../blocs/sale/sale_bloc.dart';

class SaleRouters extends StatefulWidget {
  final List<router.Router>? routers;

  const SaleRouters({super.key, this.routers});

  @override
  State<SaleRouters> createState() => _SaleRoutersState();
}

class _SaleRoutersState extends State<SaleRouters>
    with SingleTickerProviderStateMixin {
  late TabController _tabcontroller;

  @override
  void initState() {
    _tabcontroller = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return BlocBuilder<SaleBloc, SaleState>(builder: (context, state) {
      if (state.status == SaleStatus.success && widget.routers != null) {
        return Expanded(
            child: Column(children: [
          TabBar(controller: _tabcontroller, tabs: const [
            SizedBox(
              width: 200,
              child: Tab(
                text: 'Pendiente',
              ),
            ),
            SizedBox(
              width: 200,
              child: Tab(
                text: 'Historial',
              ),
            )
          ]),
          Expanded(
              child: Container(
            color: Colors.grey[200],
            child: TabBarView(controller: _tabcontroller, children: [
              BlocBuilder<SaleBloc, SaleState>(builder: (context, state) {
                if (state.status == SaleStatus.success &&
                    widget.routers != null && widget.routers!.isNotEmpty==true) {
                  return ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: widget.routers?.length,
                      itemBuilder: (context, index) {
                        return CardRouter(
                          codeRouter: widget.routers![index].dayRouter!,
                          quantityClients:
                              widget.routers![index].quantityClient.toString(),
                          dayRouter:
                              widget.routers![index].nameDayRouter.toString(),
                          totalClients: widget.routers![index].quantityClient,
                        );
                      });
                } else {
                  return Container(
                    child: Text('No hay ruteros disponibles'),
                  );
                }
              }),
              Center(
                  child: AppText('No hay ruteros',
                      fontSize: 15, fontWeight: FontWeight.w300))
            ]),
          ))
        ]));
      } else {
        return const Center(child: Text('Cargando'));
      }
    });
  }
}
/* ListView.builder(
                itemCount: routers?.length,
                itemBuilder: (context, index) {
                  return CardRouter(
                    codeRouter: routers![index].dayRouter!,
                    quantityClients: routers![index].quantityClient.toString(),
                    dayRouter: routers![index].nameDayRouter.toString(),
                    totalClients: routers![index].quantityClient,
                  );
                }) */



