/* import 'package:flutter/material.dart';

//utils
import '../../../../../utils/constants/strings.dart';

//domain
import '../../../../../domain/models/category.dart';

//services
import '../../../../../locator.dart';
import '../../../../../services/navigation.dart';

final NavigationService _navigationService = locator<NavigationService>();

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({Key? key, required this.category}) : super(key: key);

  final Category category;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          _navigationService.goTo(Routes.categoryRoute, arguments: category.id),
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Text(category.name!,
              style: const TextStyle(
                  fontSize: 20, fontWeight: FontWeight.normal))),
    );
  }
}
 */