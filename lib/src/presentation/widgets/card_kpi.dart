// ignore_for_file: must_be_immutable
import 'package:bexmovil/src/domain/models/kpi.dart';
import 'package:bexmovil/src/utils/constants/gaps.dart';
import 'package:bexmovil/src/utils/constants/screens.dart';
import 'package:bexmovil/src/utils/constants/strings.dart';

import 'package:flutter/material.dart';

class CardKpi extends StatelessWidget {
  String tittle;
  Kpi mainData;
  List<Kpi> kpiData;
  CardKpi(
      {super.key,
      required this.tittle,
      required this.kpiData,
      required this.mainData});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tittle,
              style: theme.textTheme.bodyMedium!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Text(
                  mainData.value!,
                  style: theme.textTheme.bodyMedium!
                      .copyWith(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                (mainData.percent != null && mainData.percent! < 0)
                    ? SizedBox(
                        width: 20,
                        child: Image.asset(
                          Assets.arrowDown,
                          fit: BoxFit.cover,
                        ),
                      )
                    : SizedBox(
                        width: 20,
                        child: Image.asset(
                          Assets.arrowUp,
                          fit: BoxFit.cover,
                        ),
                      ),
                gapW12,
                RichText(
                  text: TextSpan(
                    style: theme.textTheme.bodyMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                    children: <TextSpan>[
                      TextSpan(
                        text: mainData.percent! < 0
                            ? '- ${mainData.percent!.abs()} %'
                            : '+ ${mainData.percent!.abs()} %', // Signo menos si el número es negativo
                        style: TextStyle(
                          color: mainData.percent! < 0
                              ? const Color(0XFFED1F23)
                              : const Color(
                                  0XFFC2D953), // Color rojo si es negativo
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Expanded(
              child: SizedBox(
                width: Screens.width(context) / 2,
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: kpiData.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child: Text('${kpiData[index].title}')),
                            gapW12,
                            Text(kpiData[index].value!),
                            gapW12,
                            RichText(
                              text: TextSpan(
                                style: theme.textTheme.bodyMedium,
                                children: <TextSpan>[
                                  TextSpan(
                                    text: kpiData[index].percent! < 0
                                        ? '-'
                                        : '+', // Signo menos si el número es negativo
                                    style: TextStyle(
                                      color: kpiData[index].percent! < 0
                                          ? const Color(0XFFED1F23)
                                          : const Color(
                                              0XFFC2D953), // Color rojo si es negativo
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        '${kpiData[index].percent!.abs()} %', // Valor absoluto del número
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Divider(
                          color: theme.disabledColor,
                        )
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
