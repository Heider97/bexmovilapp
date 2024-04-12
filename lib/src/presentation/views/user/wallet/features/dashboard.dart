import 'package:bexmovil/src/presentation/views/user/home/widgets/card_kpi.dart';
import 'package:bexmovil/src/presentation/views/user/wallet/widgets/cartesian_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../domain/models/component.dart';
import '../../../../blocs/sale/sale_bloc.dart';
import '../../../../widgets/atoms/app_text.dart';

class WalletDashboard extends StatefulWidget {
  final List<Component>? components;

  const WalletDashboard({super.key, this.components});

  @override
  State<WalletDashboard> createState() => _WalletDashboardState();
}

class _WalletDashboardState extends State<WalletDashboard>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<SaleBloc, SaleState>(builder: (context, state) {
      if (state.status == SaleStatus.success &&
          widget.components != null &&
          widget.components!.isNotEmpty == true) {
        return SingleChildScrollView(
          child: SizedBox(
            height: size.height - 200,
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: widget.components!.length,
              itemBuilder: (c, i) {
                final component = widget.components![i];

                if (component.type == "kpi") {
                  return CardKpi(kpi: component, height: 80, needConverted: true);
                } else if (component.type == "line") {
                  return CartesianChart(component: component);
                } else {
                  return const SizedBox();
                }
              },
            ),
          ),
        );
      } else {
        return AppText('No hay graficos disponibles');
      }
    });
  }
}
