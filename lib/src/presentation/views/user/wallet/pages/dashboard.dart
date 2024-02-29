import 'package:flutter/material.dart';

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

  @override
  void initState() {
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
                      onPressed: null,
                      child: Icon(Icons.menu,
                          color: Theme.of(context)
                              .colorScheme
                              .onPrimaryContainer)),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(Const.padding),
              child: CartesianChart(),
            ),
            const Padding(
              padding: EdgeInsets.all(Const.padding),
              child: CircularChart(),
            ),
          ],
        ),
      ),
    );
  }
}
