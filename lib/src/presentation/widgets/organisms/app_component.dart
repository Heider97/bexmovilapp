import 'package:bexmovil/src/presentation/views/user/home/features/applications.dart';
import 'package:bexmovil/src/presentation/views/user/home/widgets/card_kpi.dart';
import 'package:flutter/material.dart';

import '../../../domain/models/component.dart';
import '../../../domain/models/kpi.dart';
import '../../../utils/extensions/string_extension.dart';
import '../../views/user/home/features/features.dart';
import '../atoms/app_text.dart';
import '../molecules/app_text_block.dart';
import 'app_list.dart';

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
class AppComponent extends StatefulWidget {
  /// Creates a customizable form widget.
  ///
  /// The [componentItems], [componentType]
  /// null.
  const AppComponent({
    super.key,
    required this.componentType,
    required this.componentItems,
  });

  /// The list of form items to display in the form.
  ///
  /// Must not be null.
  final String componentType;

  /// The list of form items to display in the form.
  ///
  /// Must not be null.
  final Component componentItems;

  @override
  State<AppComponent> createState() => _AppComponentState();
}

class _AppComponentState extends State<AppComponent> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    switch (widget.componentType.toEnum()) {
      case ComponentTypes.kpi:
        return const SizedBox();
        final kpi = Kpi(title: widget.componentItems.title);
        return CardKpi(kpi: kpi);
      case ComponentTypes.line:
        return const SizedBox();
      case ComponentTypes.pie:
        return const SizedBox();
      case ComponentTypes.list:
        return HomeApplications(applications: widget.componentItems.results);
      case ComponentTypes.feature:
        return HomeFeatures(features: widget.componentItems.results);
      default:
        return const SizedBox();
    }
  }
}
