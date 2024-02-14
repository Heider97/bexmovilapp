// ignore_for_file: must_be_immutable
import 'package:bexmovil/src/domain/models/kpi.dart';
import 'package:bexmovil/src/utils/constants/gaps.dart';

import 'package:bexmovil/src/utils/constants/strings.dart';

import 'package:flutter/material.dart';

class RelationKpi extends StatefulWidget {
  String tittle;
  Kpi mainData;
  List<Kpi> kpiData;
  RelationKpi(
      {super.key,
      required this.tittle,
      required this.kpiData,
      required this.mainData});

  @override
  State<RelationKpi> createState() => _RelationKpiState();
}

class _RelationKpiState extends State<RelationKpi> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      child: Card(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.tittle,
              style: theme.textTheme.bodyMedium!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Text(
                  widget.mainData.value!,
                  style: theme.textTheme.bodyMedium!
                      .copyWith(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                (widget.mainData.percent != null &&
                        widget.mainData.percent! < 0)
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
                        text: widget.mainData.percent! < 0
                            ? '- ${widget.mainData.percent!.abs()} %'
                            : '+ ${widget.mainData.percent!.abs()} %', // Signo menos si el número es negativo
                        style: TextStyle(
                          color: widget.mainData.percent! < 0
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
          ],
        ),
      )),
    );
  }
}
