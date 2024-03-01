import 'package:bexmovil/src/domain/models/kpi.dart';
import 'package:bexmovil/src/presentation/blocs/wallet/wallet_bloc.dart';
import 'package:bexmovil/src/presentation/views/user/home/widgets/card_kpi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//utils
import '../../../../../utils/constants/strings.dart';

//atoms
import '../../../../widgets/atomsbox.dart';

//widgets
import '../widgets/cartesian_chart.dart';
import '../widgets/circular_chart.dart';

class WalletDashboardView extends StatefulWidget {
  const WalletDashboardView({super.key});

  @override
  State<WalletDashboardView> createState() => _WalletDashboardViewState();
}

class _WalletDashboardViewState extends State<WalletDashboardView> {
  TextEditingController searchController = TextEditingController();

  late WalletBloc walletBloc;

  @override
  void initState() {
    walletBloc = BlocProvider.of<WalletBloc>(context);
    walletBloc.add(LoadGraphics());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(Const.padding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const AppBackButton(needPrimary: true),
                  AppIconButton(
                      onPressed: () {
                        print('********');
                        Scaffold.of(context).openEndDrawer();
                      },
                      child: Icon(Icons.menu,
                          color: Theme.of(context)
                              .colorScheme
                              .onPrimaryContainer)),
                ],
              ),
            ),
            BlocBuilder<WalletBloc, WalletState>(builder: (context, state) {
              if (state.graphics.isNotEmpty) {
                return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.graphics.length,
                    itemBuilder: (context, index) {
                      final graphic = state.graphics[index];
                      if (graphic.type == 'line') {
                        return Padding(
                            padding: const EdgeInsets.all(Const.padding),
                            child: CartesianChart(graphic: graphic));
                      } else if (graphic.type == 'kpi') {
                        return Padding(
                            padding: const EdgeInsets.all(Const.padding),
                            child: CardKpi(
                                needConverted: true,
                                height: 80,
                                kpi: Kpi(
                                    type: graphic.data!.first.x,
                                    title: graphic.title,
                                    value: graphic.data!.first.y.toString())));
                      } else {
                        return Padding(
                            padding: const EdgeInsets.all(Const.padding),
                            child: CircularChart(graphic: graphic));
                      }
                    });
              } else {
                return Center(
                  child: AppText('Vendedor no tiene graphicos configurados'),
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
