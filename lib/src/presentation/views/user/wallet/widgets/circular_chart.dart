import 'package:bexmovil/src/locator.dart';
import 'package:bexmovil/src/services/navigation.dart';
import 'package:bexmovil/src/utils/constants/gaps.dart';
import 'package:bexmovil/src/utils/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

//domain
import '../../../../../domain/models/graphic.dart';
import '../../../../widgets/atoms/app_text.dart';

final NavigationService _navigationService = locator<NavigationService>();

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
                      IconButton(
                        onPressed: () {
                          _navigationService.goTo(AppRoutes.detailWallet);
                        },
                        icon: Icon(
                          FontAwesomeIcons.upRightAndDownLeftFromCenter,
                          color: theme.primaryColor,
                          size: 18,
                        ),
                      ),
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
                onPointTap: (args) {
                  print('****************');
                },
                dataSource: graphic.data,
                pointColorMapper: (ChartData data, _) => data.color,
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) => data.y),
          ]),
          // Row(
          //   children: [
          //     Expanded(
          //       child: Column(
          //         children: [
          //           const Text('Agenda mas alta'),
          //           const Text('\$80M'),
          //           Text('Lunes',
          //               style: theme.textTheme.bodyLarge!
          //                   .copyWith(fontWeight: FontWeight.bold)),
          //         ],
          //       ),
          //     ),
          //     Expanded(
          //       child: Column(
          //         children: [
          //           const Text('Cliente más alto'),
          //           const Text('\$55M'),
          //           Text(
          //             'Pandapan',
          //             style: theme.textTheme.bodyLarge!
          //                 .copyWith(fontWeight: FontWeight.bold),
          //           ),
          //         ],
          //       ),
          //     )
          //   ],
          // ),
          gapH16
        ],
      ),
    );
  }
}
