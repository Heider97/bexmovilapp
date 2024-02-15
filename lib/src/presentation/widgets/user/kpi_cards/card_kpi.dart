import 'package:bexmovil/src/domain/models/responses/kpi_response.dart';
import 'package:bexmovil/src/utils/constants/strings.dart';

import 'package:flutter/material.dart';

class CardKpi extends StatefulWidget {
  final Kpi kpi;

  const CardKpi({super.key, required this.kpi});

  @override
  State<CardKpi> createState() => _CardKpiState();
}

class _CardKpiState extends State<CardKpi> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Card(
        surfaceTintColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.kpi.title ?? "N/A",
                style: theme.textTheme.bodyMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Text(
                    widget.kpi.value ?? "N/A",
                    style: theme.textTheme.bodyMedium!
                        .copyWith(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
