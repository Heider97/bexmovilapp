import 'package:bexmovil/src/locator.dart';
import 'package:bexmovil/src/services/navigation.dart';
import 'package:bexmovil/src/utils/constants/gaps.dart';
import 'package:bexmovil/src/utils/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

final NavigationService _navigationService = locator<NavigationService>();

class CartesianChart extends StatelessWidget {
  const CartesianChart({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    List<_SalesData> data = [
      _SalesData('CC', 0),
      _SalesData('0-30', 32865663),
      _SalesData('31-60', 53882318),
      _SalesData('61-90', 33469262),
      _SalesData('90+', 13560337)
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Cartera por edades',
                        style: theme.textTheme.bodyLarge!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        onPressed: () {
                          _navigationService.goTo(AppRoutes.charDetails);
                        },
                        icon: Icon(
                          FontAwesomeIcons.upRightAndDownLeftFromCenter,
                          color: theme.primaryColor,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                  const Text('Cartera Total'),
                  Text('\$211M',
                      style: theme.textTheme.bodyLarge!
                          .copyWith(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
          SfCartesianChart(
            primaryXAxis: const CategoryAxis(),
            legend: const Legend(
              isVisible: false,
            ),
            primaryYAxis: NumericAxis(
                // Applies currency format for y axis labels and also for data labels
                numberFormat: NumberFormat.compactCurrency(symbol: '\$')),
            onDataLabelTapped: (args) {
              print('********************');
              print(args.toString());
              print(args.pointIndex);
            },
            onAxisLabelTapped: (args) {
              print('********************');
              print(args.toString());
              print(args.axisName);
              print(args.value);
              print(args.text);
            },
            series: <CartesianSeries<_SalesData, String>>[
              ColumnSeries<_SalesData, String>(
                  onPointTap: (ChartPointDetails details) {
                    print(details.pointIndex);
                    print(details.seriesIndex);
                  },
                  dataSource: data,
                  xValueMapper: (_SalesData sales, _) => sales.x,
                  yValueMapper: (_SalesData sales, _) => sales.y,
                  borderRadius: BorderRadius.circular(15),
                  isTrackVisible: true,
                  trackColor: const Color(0XFFC6C9D0),
                  dataLabelSettings: const DataLabelSettings(isVisible: true))
            ],
          ),
          gapH12
        ],
      ),
    );
  }
}

class _SalesData {
  _SalesData(this.x, this.y);

  final String x;
  final double y;
}
