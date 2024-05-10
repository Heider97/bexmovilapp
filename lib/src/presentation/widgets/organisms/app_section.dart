import 'package:flutter/material.dart';

import '../../../domain/models/widget.dart' as w;
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
  /// The [widgetItems] parameters must not be
  /// null.
  const AppSection({
    super.key,
    required this.title,
    required this.widgetItems,
    this.tabController,
  });

  /// The optional title widget to display at the top of the form.
  final String? title;

  /// The list of form items to display in the form.
  ///
  /// Must not be null.
  final List<w.Widget> widgetItems;

  final TabController? tabController;

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
        gapH8,
        (widget.title != null)
            ? Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: AppText(widget.title!,
                    fontSize: 20, fontWeight: FontWeight.bold),
              )
            : Container(),
        ...widget.widgetItems.map(
          (item) {
            var listIndex = widget.widgetItems.indexOf(item);
            return _buildAppWidget(context, listIndex);
          },
        ),
      ],
    );
  }

  AppWidget _buildAppWidget(
    BuildContext context,
    int listIndex,
  ) {
    return AppWidget(
      name: widget.widgetItems[listIndex].name!,
      type: widget.widgetItems[listIndex].type!,
      components: widget.widgetItems[listIndex].components ?? [],
      tabController: widget.tabController,
    );
  }
}
