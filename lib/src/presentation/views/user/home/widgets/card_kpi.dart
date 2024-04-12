import 'package:flutter/material.dart';
import 'package:bexmovil/src/domain/models/kpi.dart';

//utils
import '../../../../../domain/models/component.dart';
import '../../../../../utils/constants/strings.dart';
import '../../../../../utils/extensions/string_extension.dart';

//widgets

import '../../../../widgets/atoms/app_text.dart';

class CardKpi extends StatefulWidget {
  final Component kpi;
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
                  child: AppText(widget.kpi.title ?? "N/A",
                      maxLines: 2, fontWeight: FontWeight.normal),
                ),
                Row(
                  children: [
                    AppText(buildContentKpi(),
                        fontWeight: FontWeight.normal, fontSize: 22),
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  String buildContentKpi() {
    if (widget.needConverted == true && widget.kpi.results != null) {
      print(widget.kpi.results);

      if (widget.kpi.results is List && widget.kpi.results.isNotEmpty) {
        if (widget.kpi.results.first is Kpi) {
          return "N/A";
        } else {
          if ((widget.kpi.results.first['dato'] &&
                  widget.kpi.results.first['dato'].contains('/')) ||
              (widget.kpi.results.first['x'] &&
                  widget.kpi.results.first['x'].contains('/'))) {
            var splits = [];
            if (widget.kpi.results.first['dato'] != null) {
              splits = widget.kpi.results.first['dato'].split('/');
            } else if (widget.kpi.results.first['x'] != null) {
              splits = widget.kpi.results.first['x'].split('/');
            }
            var result = [];
            for (var split in splits) {
              result.add(split.formattedCompact(split));
            }
            return result.join('/');
          } else {
            return ''.formattedCompact(widget.kpi.results!);
          }
        }
      } else {
        return "N/A";
      }
    } else {
      if (widget.kpi.results is List) {
        if (widget.kpi.results.first is Kpi) {
          return "N/A";
        } else {
          return widget.kpi.results.first['dato'];
        }
      } else {
        return "N/A";
      }
    }
  }
}
