import 'package:bexmovil/src/domain/models/kpi.dart';
import 'package:bexmovil/src/presentation/blocs/wallet/wallet_bloc.dart';
import 'package:bexmovil/src/presentation/views/user/home/widgets/card_kpi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//utils
import '../../../../../domain/models/component.dart';
import '../../../../../utils/constants/screens.dart';
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
    ThemeData theme = Theme.of(context);
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(Const.padding),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppBackButton(needPrimary: true),
                      ],
                    ),
                  ),
                  BlocBuilder<WalletBloc, WalletState>(
                      builder: (context, state) {
                    if (state.graphics != null && state.graphics!.isNotEmpty) {
                      return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.graphics!.length,
                          itemBuilder: (context, index) {
                            final graphic = state.graphics![index];
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
                                      kpi: Component(
                                          type: graphic.data!.first.x,
                                          title: graphic.title,
                                          results: graphic.data!.first.y
                                              .toString())));
                            } else {
                              return Padding(
                                  padding: const EdgeInsets.all(Const.padding),
                                  child: CircularChart(graphic: graphic));
                            }
                          });
                    } else {
                      return Center(
                        child:
                            AppText('Vendedor no tiene graphicos configurados'),
                      );
                    }
                  }),
                ],
              ),
            ),
          ),
          Container(
            width: Screens.width(context),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  navigationService.goTo(AppRoutes.manageWallet);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.primaryColor,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Text(
                  'Gestionar Cartera',
                  style: theme.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w600, color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
