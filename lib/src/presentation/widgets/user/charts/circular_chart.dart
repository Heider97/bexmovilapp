import 'package:bexmovil/src/locator.dart';
import 'package:bexmovil/src/presentation/views/user/wallet/wallet_dashboard_view.dart';
import 'package:bexmovil/src/services/navigation.dart';
import 'package:bexmovil/src/utils/constants/gaps.dart';
import 'package:bexmovil/src/utils/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

final NavigationService _navigationService = locator<NavigationService>();

class CircularChart extends StatelessWidget {
  const CircularChart({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData('David', 25),
      ChartData('Steve', 38),
      ChartData('Jack', 34),
      ChartData('Others', 52)
    ];

    ThemeData theme = Theme.of(context);
    return Card(
      color: theme.colorScheme.onPrimary,
      surfaceTintColor: theme.colorScheme.onPrimary,
      elevation: 10,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Edad',
                    style: theme.textTheme.bodyLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    onPressed: () {
                      _navigationService.goTo(Routes.charDetailsRoute);
                    },
                    icon: Icon(
                      FontAwesomeIcons.upRightAndDownLeftFromCenter,
                      color: theme.primaryColor,
                      size: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SfCircularChart(series: <CircularSeries>[
            // Render pie chart
            PieSeries<ChartData, String>(
                dataSource: chartData,
                pointColorMapper: (ChartData data, _) => data.color,
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) => data.y)
          ]),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    const Text('Edad mas alta'),
                    const Text('80'),
                    Text('Italcol',
                        style: theme.textTheme.bodyLarge!
                            .copyWith(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    const Text('Frecuencia más alta'),
                    const Text('50'),
                    Text(
                      'Pandapan',
                      style: theme.textTheme.bodyLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              )
            ],
          ),
          gapH16
        ],
      ),
    );
  }
}
