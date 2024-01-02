import 'package:bexmovil/src/presentation/widgets/global/custom_back_button.dart';
import 'package:bexmovil/src/presentation/widgets/global/custom_menu_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:bexmovil/src/presentation/widgets/user/filter_button.dart';
import 'package:bexmovil/src/utils/constants/gaps.dart';
import 'package:bexmovil/src/utils/constants/strings.dart';
import 'package:flutter/material.dart';

class WalletDashboardView extends StatefulWidget {
  const WalletDashboardView({super.key});

  @override
  State<WalletDashboardView> createState() => _WalletDashboardViewState();
}

class _WalletDashboardViewState extends State<WalletDashboardView>
    with SingleTickerProviderStateMixin {
  TextEditingController searchController = TextEditingController();
  late TabController _tabController;

  final List<ChartData> chartData = [
    ChartData('David', 25),
    ChartData('Steve', 38),
    ChartData('Jack', 34),
    ChartData('Others', 52)
  ];

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return SafeArea(
      child: Column(
        children: [
          const Padding(
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
              padding: const EdgeInsets.all(Const.padding),
              child: Container(
                decoration: BoxDecoration(
                    color: theme.colorScheme.secondary,
                    borderRadius: BorderRadius.circular(Const.space15)),
                child: Padding(
                  padding: const EdgeInsets.all(Const.padding),
                  child: Row(
                    children: [
                      Icon(
                        Icons.search,
                        color: theme.colorScheme.tertiary,
                      ),
                      gapW24,
                      Text(
                        'Busqueda por cliente',
                        style: TextStyle(color: theme.colorScheme.tertiary),
                      )
                    ],
                  ),
                ),
              )),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                FilterButton(
                  enable: true,
                  onTap: (() {}),
                  textButton: 'Edades',
                ),
                FilterButton(
                  enable: false,
                  onTap: (() {}),
                  textButton: 'Zona',
                ),
                FilterButton(
                  enable: false,
                  onTap: (() {}),
                  textButton: 'Proximidad',
                ),
                FilterButton(
                  enable: false,
                  onTap: (() {}),
                  textButton: 'Agenda',
                )
              ],
            ),
          ),
          TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: "Semanal"),
              Tab(text: "Mensual"),
              Tab(text: "3 Meses"),
            ],
            indicatorSize: TabBarIndicatorSize.tab,
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Card(
                        color: theme.colorScheme.onPrimary,
                        surfaceTintColor: theme.colorScheme.onPrimary,
                        elevation: 10,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 15.0, top: 10),
                              child: Align(
                                  alignment: Alignment.topRight,
                                  child: IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.open_in_full,
                                      color: theme.primaryColor,
                                    ),
                                  )),
                            ),
                            SfCircularChart(series: <CircularSeries>[
                              // Render pie chart
                              PieSeries<ChartData, String>(
                                  dataSource: chartData,
                                  pointColorMapper: (ChartData data, _) =>
                                      data.color,
                                  xValueMapper: (ChartData data, _) => data.x,
                                  yValueMapper: (ChartData data, _) => data.y)
                            ]),
                          ],
                        ),
                      ),
                      Icon(Icons.directions_car),
                      Icon(Icons.directions_car),
                      Icon(Icons.directions_car),
                      Icon(Icons.directions_car),
                    ],
                  ),
                ),
                Icon(Icons.directions_transit),
                Icon(Icons.directions_bike),
              ],
            ),
          )
        ],
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
