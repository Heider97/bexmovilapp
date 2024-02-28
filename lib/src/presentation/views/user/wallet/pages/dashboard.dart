import 'package:flutter/material.dart';

//utils
import '../../../../../utils/constants/strings.dart';

//atoms
import '../../../../widgets/global/custom_back_button.dart';
import '../../../../widgets/global/custom_menu_button.dart';

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
    return const SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(Const.padding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomBackButton(
                    primaryColorBackgroundMode: true,
                  ),
                  CustomMenuButton(
                    primaryColorBackgroundMode: true,
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(Const.padding),
              child: CartesianChart(),
            ),
            Padding(
              padding: EdgeInsets.all(Const.padding),
              child: CircularChart(),
            ),
            // TabBar(
            //   controller: _tabController,
            //   tabs: const [
            //     Tab(text: "Semanal"),
            //     Tab(text: "Mensual"),
            //     Tab(text: "3 Meses"),
            //   ],
            //   indicatorSize: TabBarIndicatorSize.tab,
            // ),
        
        
            // Expanded(
            //   child: TabBarView(
            //     controller: _tabController,
            //     children: const [
            //       SingleChildScrollView(
            //         child: Column(
            //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //           children: [
            //
            //           ],
            //         ),
            //       ),
            //     ],
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, [this.color]);
  final String x;
  final double y;
  final Color? color;
}
