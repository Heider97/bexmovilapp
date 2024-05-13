import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../widgets/atoms/app_text.dart';

class AppItem extends StatelessWidget {
  final bool enabled;
  final String iconName;
  final String? imagePath;
  final Function() onTap;
  const AppItem(
      {super.key,
      required this.enabled,
      required this.iconName,
      this.imagePath,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Opacity(
        opacity: enabled ? 1 : 0.3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if(imagePath != null)
              SizedBox(
                child: SvgPicture.asset(
                  imagePath!,
                  width: 40,
                  height: 40,
                ),
              ),
            AppText(iconName)
          ],
        ),
      ),
    );
  }
}
