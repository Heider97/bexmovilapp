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
    if(widget.kpi.results is String ) {
      return widget.kpi.results;
    } else {
      return "N/A";
    }

    // if (widget.needConverted == true && widget.kpi.results != null) {
    //   if (widget.kpi.results is List && widget.kpi.results.isNotEmpty) {
    //     if (widget.kpi.results.first is Kpi) {
    //       return "N/A";
    //     } else {
    //       if ((widget.kpi.results.first['dato'] != null &&
    //               widget.kpi.results.first['dato'] is String &&
    //               widget.kpi.results.first['dato'].contains('/')) ||
    //           (widget.kpi.results.first['y'] != null &&
    //               widget.kpi.results.first['y'] is String &&
    //               widget.kpi.results.first['y'].contains('/'))) {
    //         var splits = [];
    //         if (widget.kpi.results.first['dato'] != null) {
    //           splits = widget.kpi.results.first['dato'].split('/');
    //         } else if (widget.kpi.results.first['y'] != null) {
    //           splits = widget.kpi.results.first['y'].split('/');
    //         }
    //         var result = [];
    //         for (var split in splits) {
    //           split =
    //               split is int || split is double ? split.toString() : split;
    //           result.add(''.formattedCompact(split));
    //         }
    //         return result.join('/');
    //       } else {
    //         var value = '';
    //         if (widget.kpi.results.first['dato'] != null) {
    //           value = widget.kpi.results.first['dato'] is double ||
    //                   widget.kpi.results.first['dato'] is int
    //               ? widget.kpi.results.first['dato'].toString()
    //               : widget.kpi.results.first['dato'];
    //         } else if (widget.kpi.results.first['y'] != null) {
    //           value = widget.kpi.results.first['y'] is double ||
    //                   widget.kpi.results.first['y'] is int
    //               ? widget.kpi.results.first['y'].toString()
    //               : widget.kpi.results.first['y'];
    //         }
    //
    //         return ''.formattedCompact(value);
    //       }
    //     }
    //   } else {
    //     return "N/A";
    //   }
    // } else {
    //   if (widget.kpi.results is List && widget.kpi.results.isNotEmpty) {
    //     if (widget.kpi.results.first is Kpi) {
    //       return "N/A";
    //     } else {
    //       var value = widget.kpi.results.first['dato'] is int
    //           ? widget.kpi.results.first['dato'].toDouble()
    //           : widget.kpi.results.first['dato'] is String
    //               ? double.parse(widget.kpi.results.first['dato'])
    //               : widget.kpi.results.first['dato'];
    //       return ''.formatted(value);
    //     }
    //   } else {
    //     return "N/A";
    //   }
    // }
  }
}
