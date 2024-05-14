import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//blocs

import '../../../../blocs/sale/sale_bloc.dart';
//utils
import '../../../../../utils/constants/screens.dart';
//widgets
import '../../../../widgets/atoms/app_text.dart';
import '../widgets/card_router_sale.dart';

class SaleRouters extends StatefulWidget {
  const SaleRouters({super.key});

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
    return BlocBuilder<SaleBloc, SaleState>(builder: (context, state) {
      if (state.status == SaleStatus.routers && state.routers != null) {
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
              height: Screens.height(context) * 0.76,
              color: Colors.grey[200],
              child: TabBarView(controller: _tabcontroller, children: [
                BlocBuilder<SaleBloc, SaleState>(builder: (context, state) {
                  if (state.status == SaleStatus.routers &&
                      state.routers != null &&
                      state.routers!.isNotEmpty) {
                    return ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: state.routers?.length,
                        itemBuilder: (context, index) {
                          return CardRouter(router: state.routers![index]);
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
