import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//blocs
import '../../../../../domain/models/graphic.dart';
import '../../../../blocs/wallet/wallet_bloc.dart';

//domain
import '../../../../../domain/models/kpi.dart';

//widgets
import '../../../../widgets/atoms/app_text.dart';
import '../../home/widgets/card_kpi.dart';
import '../widgets/cartesian_chart.dart';

class WalletDashboard extends StatefulWidget {
  const WalletDashboard({super.key});

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
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<WalletBloc, WalletState>(builder: (context, state) {
      if (state.status == WalletStatus.dashboard &&
          state.graphics != null &&
          state.graphics!.isNotEmpty == true) {
        return SingleChildScrollView(
          child: SizedBox(
            height: size.height - 200,
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: state.graphics!.length,
              itemBuilder: (c, i) {
                final component = state.graphics![i];
                print(component.toJson());
                if (component is Kpi) {
                  return CardKpi(
                      kpi: component, height: 80, needConverted: true);
                } else if (component is Graphic) {
                  return CartesianChart(component: component);
                } else {
                  return const SizedBox();
                }
              },
            ),
          ),
        );
      } else {
        return Center(child: AppText('No hay graficos disponibles'));
      }
    });
  }
}
