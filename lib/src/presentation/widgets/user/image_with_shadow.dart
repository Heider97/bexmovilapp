import 'package:bexmovil/src/utils/constants/gaps.dart';
import 'package:bexmovil/src/utils/constants/screens.dart';
import 'package:bexmovil/src/utils/constants/strings.dart';
import 'package:flutter/material.dart';

class ImagesWithShadow extends StatelessWidget {
  final String image;
  final double gap;
  const ImagesWithShadow({super.key, required this.image, required this.gap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ClipRect(
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Image.asset(
                    image,
                    // Alto de la imagen
                    fit: BoxFit.contain, // Ajuste de la imagen
                  ),
                ),
                SizedBox(height: gap),
                Image.asset(
                  Assets.shadow,

                  fit: BoxFit.contain, // Ajuste de la imagen
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
