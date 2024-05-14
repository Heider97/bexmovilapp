import 'package:flutter/material.dart';

//domain
import '../../../../../domain/models/kpi.dart';

class RelationKpi extends StatefulWidget {
  final Kpi kpi;

  const RelationKpi({super.key, required this.kpi});

  @override
  State<RelationKpi> createState() => _RelationKpiState();
}

class _RelationKpiState extends State<RelationKpi> {
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
            widget.kpi.title ?? "N/A",
            style: theme.textTheme.bodyMedium!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              Text(
                widget.kpi.results ?? "N/A",
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
