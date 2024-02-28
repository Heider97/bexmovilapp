import 'package:flutter/material.dart';

//domain
import '../../../../../domain/models/responses/kpi_response.dart';
//utils
import '../../../../../utils/constants/gaps.dart';
import '../../../../../utils/constants/screens.dart';

//widgets
import '../widgets/card_reports.dart';
import '../widgets/card_kpi.dart';

class HomeStatistics extends StatelessWidget {
  final TabController tabController;

  final List<Kpi> kpisOneLine;
  final List<Kpi> kpisSecondLine;
  final List<Form> forms;

  const HomeStatistics(
      {super.key,
      required this.kpisOneLine,
      required this.kpisSecondLine,
      required this.forms,
      required this.tabController});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Screens.width(context),
      height: 280,
      child: Column(
        children: [
          TabBar(
            controller: tabController,
            indicatorSize: TabBarIndicatorSize.values.first,
            indicator: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              color: Colors.grey[100],
            ),
            labelColor: Colors.black,
            unselectedLabelColor: Colors.black,
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
              controller: tabController,
              children: [
                Container(
                  width: Screens.width(context) / 2,
                  color: Colors.grey[100],
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: kpisOneLine.length,
                            itemBuilder: (BuildContext context, int index) {
                              final kpi = kpisOneLine[index];
                              return CardKpi(kpi: kpi);
                            }),
                      ),
                      Expanded(
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: kpisSecondLine.length,
                            itemBuilder: (BuildContext context, int index) {
                              final kpi = kpisSecondLine[index];
                              return CardKpi(kpi: kpi);
                            }),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.grey[100],
                  child: Column(
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
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
