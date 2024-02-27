import 'package:flutter/material.dart';

//domain
import '../../../../../domain/models/responses/kpi_response.dart';
//utils
import '../../../../../utils/constants/gaps.dart';
import '../../../../../utils/constants/screens.dart';

class StatisticsHomeFeature extends StatelessWidget {
  final TabController tabController;

  final List<Kpi> kpis;
  final List<Form> forms;

  const StatisticsHomeFeature(
      {super.key,
      required this.kpis,
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
                      // Expanded(
                      //   child: ListView.builder(
                      //       scrollDirection: Axis.horizontal,
                      //       itemCount: length1line,
                      //       itemBuilder: (BuildContext context, int index) {
                      //         if (amountWalletKpi1line != 0 && index == 0) {
                      //           return SizedBox(
                      //               width: Screens.width(context) / 1.6,
                      //               child: CarouselSlider(
                      //                 options: CarouselOptions(
                      //                   autoPlayInterval:
                      //                       const Duration(seconds: 4),
                      //                   aspectRatio: 2,
                      //                   enlargeCenterPage: true,
                      //                   scrollDirection: Axis.vertical,
                      //                   autoPlay: true,
                      //                   viewportFraction: 1,
                      //                 ),
                      //                 items: (state.kpis != null)
                      //                     ? state.kpis!
                      //                         .where((kpi) =>
                      //                             kpi.type == "wallet" &&
                      //                             kpi.line == 1)
                      //                         .map((kpi) => WalletKpi(kpi: kpi))
                      //                         .toList()
                      //                     : [],
                      //               ));
                      //         }
                      //
                      //         if (index == 0) {
                      //           return CardKpi(kpi: othersKpi1Line[index]);
                      //         } else if (amountWalletKpi1line != 0) {
                      //           return CardKpi(kpi: othersKpi1Line[index - 1]);
                      //         } else {
                      //           return CardKpi(kpi: othersKpi1Line[index]);
                      //         }
                      //       }),
                      // ),
                      // Expanded(
                      //   //LINE 2 LIST
                      //   child: ListView.builder(
                      //       scrollDirection: Axis.horizontal,
                      //       itemCount: length2line,
                      //       itemBuilder: (BuildContext context, int index) {
                      //         if (amountWalletKpi2line != 0 && index == 0) {
                      //           return SizedBox(
                      //               width: Screens.width(context) / 1.6,
                      //               child: CarouselSlider(
                      //                 options: CarouselOptions(
                      //                   autoPlayInterval:
                      //                       const Duration(seconds: 4),
                      //                   aspectRatio: 2,
                      //                   enlargeCenterPage: true,
                      //                   scrollDirection: Axis.vertical,
                      //                   autoPlay: true,
                      //                   viewportFraction: 1,
                      //                 ),
                      //                 items: (state.kpis != null)
                      //                     ? state.kpis!
                      //                         .where((kpi) =>
                      //                             kpi.type == "wallet" &&
                      //                             kpi.line == 2)
                      //                         .map((kpi) => WalletKpi(kpi: kpi))
                      //                         .toList()
                      //                         .reversed
                      //                         .toList()
                      //                     : [],
                      //               ));
                      //         }
                      //
                      //         if (index == 0) {
                      //           return CardKpi(kpi: othersKpi2Line[index]);
                      //         } else if (amountWalletKpi2line != 0) {
                      //           return CardKpi(kpi: othersKpi2Line[index - 1]);
                      //         } else {
                      //           return CardKpi(kpi: othersKpi2Line[index]);
                      //         }
                      //       }),
                      // ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.grey[100],
                  child: Column(
                    children: [
                      gapH12,
                      // CardReports(
                      //     iconCard: Icons.star_rate_rounded,
                      //     urlIcon: "assets/svg/wallet-money.svg",
                      //     tittle: "Mi\nPresupuesto",
                      //     eventCard: () {}),
                      // gapH12,
                      // CardReports(
                      //     iconCard: Icons.star_rate_rounded,
                      //     urlIcon: "assets/svg/graphic.svg",
                      //     tittle: "Mis\nestadísticas",
                      //     eventCard: () {}),
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
