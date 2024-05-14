import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//blocs
import '../../../../blocs/sale/sale_bloc.dart';
//utils
import '../../../../../utils/constants/screens.dart';

//widgets
import '../../../../widgets/atoms/app_text.dart';
import '../widgets/card_client.dart';

class SaleClients extends StatefulWidget {
  const SaleClients({super.key});

  @override
  State<SaleClients> createState() => _SaleClientsState();
}

class _SaleClientsState extends State<SaleClients>
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
              Tab(
                text: 'Sin visitar',
              ),
              Tab(
                text: 'Visitados',
              ),
            ],
            indicatorSize: TabBarIndicatorSize.tab),
        Expanded(
          child: TabBarView(controller: _tabcontroller, children: [
            BlocBuilder<SaleBloc, SaleState>(builder: (context, state) {
              if ((state.status == SaleStatus.clients ||
                      state.status == SaleStatus.warehouses) &&
                  state.clients != null &&
                  state.clients!.isNotEmpty) {
                return ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: state.clients?.length,
                    itemBuilder: (context, index) {
                      return CardClient(
                          codrouter: state.router!.dayRouter,
                          client: state.clients![index]);
                    });
              } else {
                return const Text('No hay clientes disponibles');
              }
            }),
          ]),
        ),
      ]),
    );
  }
}
