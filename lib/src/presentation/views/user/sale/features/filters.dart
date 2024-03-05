import 'package:flutter/cupertino.dart';
//domain
import '../../../../../domain/models/filter.dart';
import '../../../../../domain/models/option.dart';
import '../../../../widgets/atomsbox.dart';

class FilterFeatureSalePage extends StatelessWidget {
  final Filter filter;

  const FilterFeatureSalePage({super.key, required this.filter});

  @override
  Widget build(BuildContext context) {
    if (filter.type == 'checkboxes') {
      return AppListTile(
          title: AppText(filter.name!),
          subtitle: Wrap(
            runSpacing: 10.0,
            spacing: 10.0,
            children: List<Option>.from(filter.options!)
                .map((e) => AppElevatedButton(
                    onPressed: () {}, child: AppText(e.name!)))
                .toList(),
          ));
    } else if (filter.type == 'range') {
      return AppListTile(title: AppText(filter.name!));
    } else {
      return const SizedBox();
    }
  }
}
