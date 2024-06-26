import 'package:bexmovil/src/locator.dart';
import 'package:bexmovil/src/services/navigation.dart';
import 'package:bexmovil/src/utils/constants/gaps.dart';
import 'package:bexmovil/src/utils/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

//domain
import '../../../../../domain/models/arguments.dart';
import '../../../../../domain/models/graphic.dart';

//widgets
import '../../../../widgets/atoms/app_text.dart';

final NavigationService navigationService = locator<NavigationService>();

class CircularChart extends StatelessWidget {
  final Graphic graphic;

  const CircularChart({super.key, required this.graphic});

  @override
  Widget build(BuildContext context) {
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
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText(graphic.title!, fontWeight: FontWeight.bold),
                    ],
                  ),
                  if (graphic.subtitle != null) AppText(graphic.subtitle!)
                ],
              ),
            ),
          ),
          SfCircularChart(series: <CircularSeries>[
            // Render pie chart
            PieSeries<ChartData, String>(
                dataLabelSettings: const DataLabelSettings(),
                onPointTap: (args) {
                  final data = graphic.data?.elementAt(args.pointIndex!);
                  if (data != null && graphic.interactive == true) {
                    var arguments = WalletArgument(type: data.x);
                    navigationService.goTo(AppRoutes.clientsWallet,
                        arguments: arguments);
                  }
                },
                dataSource: graphic.data,
                pointColorMapper: (ChartData data, _) => data.color,
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) => double.parse(data.y)),
          ]),
          gapH16
        ],
      ),
    );
  }
}
