import 'package:flutter/material.dart';

//utils
import '../../../../../utils/constants/nums.dart';

//domain
import '../../../../../domain/models/category.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({Key? key, required this.category}) : super(key: key);

  final Category category;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: categoryHeight,
      alignment: Alignment.centerLeft,
      color: Colors.white,
      child: Text(category.name,
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
    );
  }
}