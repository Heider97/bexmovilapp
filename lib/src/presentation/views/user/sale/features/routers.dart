import 'package:bexmovil/src/presentation/views/user/sale/widgets/card_router_sale.dart';
import 'package:bexmovil/src/presentation/widgets/atoms/app_text.dart';
import 'package:bexmovil/src/utils/constants/screens.dart';
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
    final size = MediaQuery.of(context).size;
    return BlocBuilder<SaleBloc, SaleState>(builder: (context, state) {
      if (state.status == SaleStatus.showRouters && widget.routers != null) {
        return SingleChildScrollView(
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
            Container(
              height: Screens.height(context)*0.76,
              color: Colors.grey[200],
              child: TabBarView(controller: _tabcontroller, children: [
                BlocBuilder<SaleBloc, SaleState>(builder: (context, state) {
                  if (state.status == SaleStatus.showRouters &&
                      widget.routers != null &&
                      widget.routers!.isNotEmpty == true) {
                    return ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: widget.routers?.length,
                        itemBuilder: (context, index) {
                          return CardRouter(router: widget.routers![index]);
                        });
                  } else {
                    return const Text('No hay ruteros disponibles');
                  }
                }),
                Center(
                    child: AppText('No hay ruteros',
                        fontSize: 15, fontWeight: FontWeight.w300))
              ]),
            )
          ]),
        );
      } else {
        return const Center(child: Text('Cargando'));
      }
    });
  }
}
