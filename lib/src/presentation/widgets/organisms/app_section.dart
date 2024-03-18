import 'package:bexmovil/src/domain/models/component.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/gaps.dart';
import '../atoms/app_text.dart';
import '../organisms/app_component.dart';

/// A customizable form widget.
///
/// The [AppSection] widget displays a form with an optional title and description,
/// a list of form items, and a form button. The form items are displayed with
/// their associated labels.
///
/// See also:
///
/// * [AppText], which is used to display the title.
class AppSection extends StatefulWidget {
  /// Creates a customizable form widget.
  ///
  /// The [componentItems] parameters must not be
  /// null.
  const AppSection({
    super.key,
    required this.title,
    required this.componentItems,
  });

  /// The optional title widget to display at the top of the form.
  final String title;

  /// The list of form items to display in the form.
  ///
  /// Must not be null.
  final List<Component> componentItems;

  @override
  State<AppSection> createState() => _AppFormState();
}

class _AppFormState extends State<AppSection> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        gapH20,
        AppText(widget.title, fontSize: 20, fontWeight: FontWeight.bold),
        ...widget.componentItems.map(
          (item) {
            var listIndex = widget.componentItems.indexOf(item);
            return _buildAppTextFormField(context, listIndex);
          },
        ),
      ],
    );
  }

  AppComponent _buildAppTextFormField(
    BuildContext context,
    int listIndex,
  ) {
    return AppComponent(
        componentType: widget.componentItems[listIndex].type!,
        componentItems: widget.componentItems[listIndex]);
  }
}
