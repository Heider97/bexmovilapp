import 'package:flutter/material.dart';

//domain
import '../../../../../domain/models/kpi.dart';
//utils
import '../../../../../utils/constants/gaps.dart';
import '../../../../../utils/constants/screens.dart';

//widgets
import '../widgets/card_reports.dart';
import '../widgets/card_kpi.dart';
import '../widgets/slide_kpi.dart';

class HomeStatistics extends StatelessWidget {
  final TabController tabController;

  final List<Kpi> kpis;
  final List<Form> forms;

  const HomeStatistics(
      {super.key,
      required this.kpis,
      required this.forms,
      required this.tabController});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Screens.width(context),
      child: Column(
        children: [
          TabBar(
            controller: tabController,
            indicatorSize: TabBarIndicatorSize.values.first,
            indicator: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            ),
            tabs: const [
              Tab(
                text: 'KPI',
              ),
              Tab(
                text: 'Informes',
              ),
            ],
          ),
          // Expanded(
          //   child: TabBarView(
          //     controller: tabController,
          //     children: [
          //       // SizedBox(
          //       //   width: Screens.width(context) / 2,
          //       //   child: Column(
          //       //     children: [
          //       //       Expanded(
          //       //         child: ListView.builder(
          //       //             scrollDirection: Axis.horizontal,
          //       //             itemCount: kpisOneLine.length,
          //       //             itemBuilder: (BuildContext context, int index) {
          //       //               final kpi = kpisOneLine[index];
          //       //               return CardKpi(kpi: kpi);
          //       //             }),
          //       //       ),
          //       //       Expanded(
          //       //         child: ListView.builder(
          //       //             scrollDirection: Axis.horizontal,
          //       //             itemCount: kpisSlidableSecondLine.length +
          //       //                 kpisSecondLine.length,
          //       //             itemBuilder: (BuildContext context, int index) {
          //       //               if (kpisSlidableSecondLine.isNotEmpty) {
          //       //                 return SlidableKpi(
          //       //                     kpis: kpisSlidableSecondLine[index]);
          //       //               }
          //       //               final kpi = kpisSecondLine[index];
          //       //               return CardKpi(kpi: kpi);
          //       //             }),
          //       //       ),
          //       //     ],
          //       //   ),
          //       // ),
          //       Column(
          //         children: [
          //           gapH12,
          //           CardReports(
          //               iconCard: Icons.star_rate_rounded,
          //               urlIcon: "assets/svg/wallet-money.svg",
          //               title: "Mi\nPresupuesto",
          //               eventCard: () {}),
          //           gapH12,
          //           CardReports(
          //               iconCard: Icons.star_rate_rounded,
          //               urlIcon: "assets/svg/graphic.svg",
          //               title: "Mis\nestadísticas",
          //               eventCard: () {}),
          //         ],
          //       )
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
