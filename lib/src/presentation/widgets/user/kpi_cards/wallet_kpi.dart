import 'package:bexmovil/src/domain/models/responses/kpi_response.dart';

import 'package:flutter/material.dart';

class WalletKpi extends StatefulWidget {
  final Kpi kpi;
  const WalletKpi({
    super.key,
    required this.kpi,
  });

  @override
  State<WalletKpi> createState() => _WalletKpiState();
}

class _WalletKpiState extends State<WalletKpi> {
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
                  /*        SizedBox(
                    width: 20,
                    child: Image.asset(
                      Assets.arrowDown,
                      fit: BoxFit.cover,
                    ),
                  ) */
                ],
              ),
            ],
          ),
        ));
  }
}
