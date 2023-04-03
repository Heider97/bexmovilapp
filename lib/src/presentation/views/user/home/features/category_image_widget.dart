import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'dart:io' as io;

class CategoryImageWidget extends StatelessWidget {
  const CategoryImageWidget({Key? key, required this.image}) : super(key: key);

  final String image;

  @override
  Widget build(BuildContext context) {
    if (io.File(image).existsSync()) {
      return Positioned(
          right: -25,
          bottom: -55,
          child: SvgPicture.asset(image, height: 170, width: 170));
    } else {
      return Container();
    }
  }
}
