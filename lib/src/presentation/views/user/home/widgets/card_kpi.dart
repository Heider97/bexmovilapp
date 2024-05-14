import 'package:flutter/material.dart';

//utils
import '../../../../../utils/constants/strings.dart';
import '../../../../../utils/extensions/string_extension.dart';

//domain
import '../../../../../domain/models/kpi.dart';

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
    return Card(
        surfaceTintColor: Colors.white,
        child: SizedBox(
          width: 200,
          height: widget.height,
          child: Padding(
            padding: const EdgeInsets.all(Const.padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: AppText(widget.kpi.title ?? "N/A", maxLines: 2),
                ),
                Row(
                  children: [
                    AppText(buildContentKpi(), fontSize: 20),
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  String buildContentKpi() {
    if (widget.kpi.results is String) {
      if (widget.kpi.results.contains('/')) {
        var splits = widget.kpi.results.split('/');
        var result = [];

        for (var split in splits) {
          split = split is int || split is double ? split.toString() : split;
          result.add(''.formattedCompact(split));
        }

        return result.join('/');
      } else {
        return widget.kpi.results;
      }
    } else if (widget.kpi.results is int) {
      return ''.formatted(widget.kpi.results.toDouble());
    } else if (widget.kpi.results is double) {
      return ''.formattedCompact(widget.kpi.results);
    } else {
      return "N/A";
    }
  }
}
