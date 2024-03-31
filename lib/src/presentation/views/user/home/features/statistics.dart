import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

//domain
import '../../../../../domain/models/component.dart';
//utils
import '../../../../../utils/constants/gaps.dart';
import '../../../../../utils/constants/screens.dart';

//widgets
import '../widgets/card_reports.dart';
import '../widgets/card_kpi.dart';
import '../widgets/slide_kpi.dart';

class HomeStatistics extends StatefulWidget {
  final TabController tabController;

  final List<Component?> kpis;
  final List<Component?> forms;

  const HomeStatistics(
      {super.key,
      required this.kpis,
      required this.forms,
      required this.tabController});

  @override
  State<HomeStatistics> createState() => _HomeStatisticsState();
}

class _HomeStatisticsState extends State<HomeStatistics> {
  List<Component?> kpisOneLine = [];
  List<Component?> kpisSecondLine = [];
  List<List<Component?>> kpisSlidableOneLine = [];
  List<List<Component?>> kpisSlidableSecondLine = [];

  @override
  void initState() {
    kpisOneLine = widget.kpis.where((element) => element!.line == 1).toList();
    print(kpisOneLine.length);

    kpisSecondLine =
        widget.kpis.where((element) => element!.line == 2).toList();

    // final duplicatesOneLine = groupBy(
    //   kpisOneLine,
    //   (kpi) => kpi!.type,
    // )
    //     .values
    //     .where((list) => list.length > 1)
    //     .map((list) => list.first!.type)
    //     .toList();

    final duplicatesSecondLine = groupBy(
      kpisSecondLine,
      (kpi) => kpi!.type,
    )
        .values
        .where((list) => list.length > 1)
        .map((list) => list.first!.type)
        .toList();

    // if (duplicatesOneLine.isNotEmpty) {
    //   for (var dsl in duplicatesOneLine) {
    //     kpisOneLine.removeWhere((element) => element!.type == dsl);
    //     kpisSlidableOneLine
    //         .add(kpisOneLine.where((kpi) => kpi!.type == dsl).toList());
    //   }
    // }

    if (duplicatesSecondLine.isNotEmpty) {
      for (var dsl in duplicatesSecondLine) {
        kpisSlidableSecondLine
            .add(kpisSecondLine.where((kpi) => kpi!.type == dsl).toList());
        kpisSecondLine.removeWhere((element) => element!.type == dsl);
      }
    }

    print(kpisOneLine.length);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Screens.width(context),
      height: 280,
      child: Column(
        children: [
          TabBar(
            controller: widget.tabController,
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
          Expanded(
            child: TabBarView(
              controller: widget.tabController,
              children: [
                SizedBox(
                  width: Screens.width(context) / 2,
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: kpisSlidableOneLine.length +
                                kpisOneLine.length,
                            itemBuilder: (BuildContext context, int index) {
                              if (kpisSlidableOneLine.isNotEmpty) {
                                return SlidableKpi(
                                    kpis: kpisSlidableOneLine[index]);
                              }
                              final kpi = kpisOneLine[index];
                              return CardKpi(kpi: kpi!);
                            }),
                      ),
                      Expanded(
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: kpisSlidableSecondLine.length +
                                kpisSecondLine.length,
                            itemBuilder: (BuildContext context, int index) {
                              if (kpisSlidableSecondLine.isNotEmpty) {
                                return SlidableKpi(
                                    kpis: kpisSlidableSecondLine[index]);
                              }
                              final kpi = kpisSecondLine[index];
                              return CardKpi(kpi: kpi!);
                            }),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    gapH12,
                    CardReports(
                        iconCard: Icons.star_rate_rounded,
                        urlIcon: "assets/svg/wallet-money.svg",
                        title: "Mi\nPresupuesto",
                        eventCard: () {}),
                    gapH12,
                    CardReports(
                        iconCard: Icons.star_rate_rounded,
                        urlIcon: "assets/svg/graphic.svg",
                        title: "Mis\nestadísticas",
                        eventCard: () {}),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
