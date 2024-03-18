import 'package:flutter/material.dart';

import '../../../domain/models/component.dart';
import '../../../utils/extensions/string_extension.dart';
import '../molecules/app_text_block.dart';

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
  State<AppComponent> createState() => _AppFormState();
}

class _AppFormState extends State<AppComponent> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    switch (widget.componentType.toEnum()) {
      case ComponentTypes.kpi:
        return const SizedBox();
      case ComponentTypes.line:
        return const SizedBox();
      case ComponentTypes.pie:
        return const SizedBox();
      case ComponentTypes.list:
        return const SizedBox();
      case ComponentTypes.feature:
        return const SizedBox();
      default:
        return const SizedBox();
    }
  }
}
