import 'package:bexmovil/src/presentation/widgets/global/custom_back_button.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'dashboard.dart';

class CharDetails extends StatefulWidget {
  const CharDetails({super.key});

  @override
  State<CharDetails> createState() => _CharDetailsState();
}

class _CharDetailsState extends State<CharDetails> {
  final List<ChartData> chartData = [
    ChartData('David', 25),
    ChartData('Steve', 38),
    ChartData('Jack', 34),
    ChartData('Others', 52)
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return SafeArea(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                CustomBackButton(
                  primaryColorBackgroundMode: true,
                )
              ],
            ),
          ),
          Expanded(
              child: SfCircularChart(
                  title: const ChartTitle(text: 'Title Chart'),
                  legend: const Legend(
                      isVisible: true,
                      title: LegendTitle(text: 'Chart Subtitle')),
                  enableMultiSelection: true,
                  series: <CircularSeries>[
                // Render pie chart
                PieSeries<ChartData, String>(
                    explode: true,
                    explodeIndex: 0,
                    dataSource: chartData,
                    pointColorMapper: (ChartData data, _) => data.color,
                    xValueMapper: (ChartData data, _) => data.x,
                    yValueMapper: (ChartData data, _) => data.y,
                    dataLabelMapper: (ChartData data, _) => data.x,
                    dataLabelSettings:
                        const DataLabelSettings(isVisible: true)),
              ]))
        ],
      ),
    );
  }
}
