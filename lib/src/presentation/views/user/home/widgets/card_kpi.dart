import 'package:flutter/material.dart';
import 'package:bexmovil/src/domain/models/kpi.dart';

//utils
import '../../../../../utils/extensions/string_extension.dart';

//widgets

import '../../../../widgets/atoms/app_text.dart';

class CardKpi extends StatefulWidget {
  final Kpi kpi;
  final double? height;
  final bool needConverted;

  const CardKpi(
      {super.key, required this.kpi, this.height, this.needConverted = false});

  @override
  State<CardKpi> createState() => _CardKpiState();
}

class _CardKpiState extends State<CardKpi> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Card(
        surfaceTintColor: Colors.white,
        child: SizedBox(
          width: 230,
          height: widget.height,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: AppText(widget.kpi.title ?? "N/A",
                      maxLines: 2, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    AppText(
                        widget.needConverted == true && widget.kpi.value != null
                            ? ''.formatted(double.parse(widget.kpi.value!))
                            : widget.kpi.value ?? "N/A",
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
