import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//blocs
import '../../../../blocs/sale/sale_bloc.dart';

//widgets
import '../../../../widgets/atoms/app_text.dart';
import '../widgets/card_client.dart';

class SaleProducts extends StatefulWidget {
  // final List<Product>? products;

  const SaleProducts({super.key});

  @override
  State<SaleProducts> createState() => _SaleProductsState();
}

class _SaleProductsState extends State<SaleProducts>
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
      if (state.status == SaleStatus.success && state.clients != null) {
        return Expanded(
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
          Expanded(
              child: Container(
            color: Colors.grey[200],
            child: TabBarView(controller: _tabcontroller, children: [
              BlocBuilder<SaleBloc, SaleState>(builder: (context, state) {
                if (state.status == SaleStatus.success &&
                    state.clients != null &&
                    state.clients!.isNotEmpty == true) {
                  return ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: state.clients?.length,
                      itemBuilder: (context, index) {
                        return CardClient(client: state.clients![index]);
                      });
                } else {
                  return const Text('No hay clientes disponibles');
                }
              }),
              Center(
                  child: AppText('No hay clientes',
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
