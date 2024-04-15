import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

//blocs
import '../../../../../domain/models/graphic.dart';
import '../../../../blocs/wallet/wallet_bloc.dart';

//utils
import '../../../../../utils/constants/gaps.dart';
import '../../../../../utils/constants/strings.dart';
//domain
import '../../../../../domain/models/component.dart';
import '../../../../../domain/models/arguments.dart';
//widgets

import '../../../../widgets/atoms/app_text.dart';

class CartesianChart extends StatelessWidget {
  final Component component;

  const CartesianChart({super.key, required this.component});

  @override
  Widget build(BuildContext context) {
    final navigationService = context.read<WalletBloc>().navigationService;
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText(component.title!, fontWeight: FontWeight.bold),
                    ],
                  ),
                  if (component.subtitle != null) AppText(component.subtitle!)
                ],
              ),
            ),
          ),
          SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            legend: const Legend(
              isVisible: false,
            ),
            primaryYAxis: NumericAxis(
                // Applies currency format for y axis labels and also for data labels
                numberFormat: NumberFormat.compactCurrency(symbol: '\$')),
            onDataLabelTapped: (args) {
              final data = component.results?.elementAt(args.pointIndex);
              if (data != null && component.interactive == true) {
                var arguments = WalletArgument(type: data.x);
                navigationService.goTo(AppRoutes.clientsWallet,
                    arguments: arguments);
              }
            },
            series: <CartesianSeries<ChartData, String>>[
              ColumnSeries<ChartData, String>(
                  onPointTap: (ChartPointDetails details) {
                    final data = component.results?.elementAt(details.pointIndex!);
                    if (data != null && component.interactive == 1) {
                      var arguments = WalletArgument(type: data.x);
                      navigationService.goTo(AppRoutes.clientsWallet,
                          arguments: arguments);
                    }
                  },
                  dataSource: component.results!,
                  xValueMapper: (ChartData sales, _) => sales.x,
                  yValueMapper: (ChartData sales, _) => double.parse(sales.y),
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
