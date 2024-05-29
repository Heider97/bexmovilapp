import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//blocs
import '../../../../blocs/sale/sale_bloc.dart';

//widgets
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
    return Expanded(
      child: Column(children: [
        TabBar(
            controller: _tabcontroller,
            tabs: const [
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
            ],
            indicatorSize: TabBarIndicatorSize.tab),
        Expanded(
          child: TabBarView(controller: _tabcontroller, children: [
            BlocBuilder<SaleBloc, SaleState>(builder: (context, state) {
              if (state.status == SaleStatus.routers &&
                  state.routers != null &&
                  state.routers!.isNotEmpty) {
                return ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: state.routers?.length,
                    itemBuilder: (context, index) {
                      return CardRouterSale(router: state.routers![index]);
                    });
              } else {
                return const Text('No hay ruteros disponibles');
              }
            }),
            BlocBuilder<SaleBloc, SaleState>(builder: (context, state) {
              if (state.status == SaleStatus.routers &&
                  state.historical != null &&
                  state.historical!.isNotEmpty) {
                return ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: state.historical?.length,
                    itemBuilder: (context, index) {
                      return CardRouterSale(router: state.historical![index]);
                    });
              } else {
                return const Center(
                    child: Text('No hay historico disponibles'));
              }
            }),
          ]),
        ),
      ]),
    );
  }
}
