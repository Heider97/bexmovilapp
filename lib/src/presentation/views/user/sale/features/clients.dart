import 'package:bexmovil/src/presentation/views/user/sale/widgets/card_client.dart';
import 'package:bexmovil/src/presentation/widgets/atoms/app_text.dart';
import 'package:bexmovil/src/utils/constants/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../domain/models/client.dart';
import '../../../../blocs/sale/sale_bloc.dart';

class SaleClients extends StatefulWidget {
  final List<Client>? clients;

  const SaleClients({super.key, this.clients});

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
    return BlocBuilder<SaleBloc, SaleState>(builder: (context, state) {
      if (state.status == SaleStatus.clients && widget.clients != null) {
        return Column(children: [
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
          SizedBox(
            height: Screens.height(context) * 0.69,
            child: TabBarView(controller: _tabcontroller, children: [
              BlocBuilder<SaleBloc, SaleState>(builder: (context, state) {
                if (state.status == SaleStatus.clients &&
                    widget.clients != null &&
                    widget.clients!.isNotEmpty == true) {
                  return ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: widget.clients?.length,
                      itemBuilder: (context, index) {
                        return CardClient(
                            codrouter: state.selectedRouter!.dayRouter,
                            client: widget.clients![index]);
                      });
                } else {
                  return const Text('No hay clientes disponibles');
                }
              }),
              Center(
                  child: AppText('No hay clientes',
                      fontSize: 15, fontWeight: FontWeight.w300))
            ]),
          )
        ]);
      } else {
        return const Center(child: Text('Cargando'));
      }
    });
  }
}
