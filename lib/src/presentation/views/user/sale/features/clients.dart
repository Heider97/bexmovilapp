import 'package:bexmovil/src/presentation/views/user/sale/widgets/card_client.dart';
import 'package:bexmovil/src/presentation/widgets/atoms/app_text.dart';
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
    final size = MediaQuery.of(context).size;
    return BlocBuilder<SaleBloc, SaleState>(builder: (context, state) {
      if (state.status == SaleStatus.success && widget.clients != null) {
        return SingleChildScrollView(
            child: Column(children: [
          TabBar(controller: _tabcontroller, tabs: const [
            SizedBox(
              width: 200,
              child: Tab(
                text: 'Sin visitar',
              ),
            ),
            SizedBox(
              width: 200,
              child: Tab(
                text: 'Visitados',
              ),
            )
          ]),
          Container(
            height: size.height - 252,
            color: Colors.grey[200],
            child: TabBarView(controller: _tabcontroller, children: [
              BlocBuilder<SaleBloc, SaleState>(builder: (context, state) {
                if (state.status == SaleStatus.success &&
                    widget.clients != null &&
                    widget.clients!.isNotEmpty == true) {
                  return ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: widget.clients?.length,
                      itemBuilder: (context, index) {
                        return CardClient(client: widget.clients![index]);
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
        ]));
      } else {
        return const Center(child: Text('Cargando'));
      }
    });
  }
}
