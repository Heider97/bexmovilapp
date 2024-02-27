import 'package:bexmovil/src/locator.dart';
import 'package:bexmovil/src/services/navigation.dart';
import 'package:bexmovil/src/utils/constants/gaps.dart';
import 'package:bexmovil/src/utils/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

final NavigationService _navigationService = locator<NavigationService>();

class CartesianChart extends StatelessWidget {
  const CartesianChart({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    List<_SalesData> data = [
      _SalesData('10', 0),
      _SalesData('20', 20),
      _SalesData('30', 40),
      _SalesData('40', 60),
      _SalesData('50', 80),
      _SalesData('50', 100)
    ];

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
          SfCartesianChart(
            primaryXAxis: const CategoryAxis(),
            legend: const Legend(
              isVisible: false,
            ),
            series: <CartesianSeries<_SalesData, String>>[
              ColumnSeries<_SalesData, String>(
                  dataSource: data,
                  xValueMapper: (_SalesData sales, _) => sales.year,
                  yValueMapper: (_SalesData sales, _) => sales.sales,
                  borderRadius: BorderRadius.circular(15),
                  isTrackVisible: true,
                  trackColor: const Color(0XFFC6C9D0),
                  dataLabelSettings: const DataLabelSettings(isVisible: true))
            ],
          ),
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

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
