
import 'package:bexmovil/src/presentation/views/user/home/features/statistics.dart';
import 'package:bexmovil/src/presentation/views/user/sale/features/routers.dart';
import 'package:flutter/material.dart';

import '../../../domain/models/component.dart';
import '../../../domain/models/kpi.dart';
import '../../../utils/extensions/string_extension.dart';

import '../molecules/app_text_block.dart';

import '../../views/user/home/features/features.dart';
import '../../views/user/home/features/applications.dart';
import '../../views/user/home/widgets/card_kpi.dart';

enum ComponentTypes { kpi, feature, line, pie, list }

/// A customizable form widget.
///
/// The [AppComponent] widget displays a form with an optional title and description,
/// a list of form items, and a form button. The form items are displayed with
/// their associated labels.
///
/// See also:
///
/// * [AppTextBlock], which is used to display the title and description.
class AppWidget extends StatefulWidget {
  /// Creates a customizable form widget.
  ///
  /// The [components], [type], [name]
  /// null.
  const AppWidget({
    super.key,
    required this.name,
    required this.type,
    required this.components,
    this.tabController
  });

  /// The list of form items to display in the form.
  ///
  /// Must not be null.
  final String name;
  final String type;

  /// The list of form items to display in the form.
  ///
  /// Must not be null.
  final List<Component> components;

  final TabController? tabController;

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    switch (widget.name) {
      case 'HomeFeatures':
        
        return HomeFeatures(features: []);

      // case ComponentTypes.kpi:
      //   return const SizedBox();
      //   return HomeStatistics(kpisOneLine: [], kpisSlidableOneLine: [], kpisSecondLine: [], kpisSlidableSecondLine: [], forms: [], tabController: widget.tabController!);
      // case ComponentTypes.line:
      //   return const SizedBox();
      // case ComponentTypes.pie:
      //   return const SizedBox();
      // case ComponentTypes.list:
        // if(widget.type == 'List<Application>') {
        //   return HomeApplications(applications: widget.components.results);
        // } else {
        //   return SaleRouters(routers: widget.componentItems.results);
        // }

      default:
        return const SizedBox();
    }
  }
}
