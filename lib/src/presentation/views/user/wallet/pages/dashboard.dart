import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//blocs
import 'package:bexmovil/src/presentation/blocs/wallet/wallet_bloc.dart';

//utils
import '../../../../../utils/constants/screens.dart';
import '../../../../../utils/constants/strings.dart';

//widgets
import '../../../../widgets/organisms/app_section.dart';
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
    final Size size = MediaQuery.of(context).size;
    ThemeData theme = Theme.of(context);

    return BlocBuilder<WalletBloc, WalletState>(builder: (context, state) {
      if (state.status == WalletStatus.loading) {
        return const Center(
            child: CupertinoActivityIndicator(color: Colors.green));
      } else {
        return _buildBody(size, theme, state, context);
      }
    });
  }

  Widget _buildBody(
      Size size, ThemeData theme, WalletState state, BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          // ...state.sections != null
          //     ? state.sections!.map((e) => AppSection(
          //           title: e.name!,
          //           widgetItems: e.widgets ?? [],
          //         ))
          //     : [],
          SizedBox(
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
