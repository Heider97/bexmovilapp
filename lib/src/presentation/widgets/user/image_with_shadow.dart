import 'package:bexmovil/src/utils/constants/strings.dart';
import 'package:flutter/material.dart';

class ImagesWithShadow extends StatelessWidget {
  final String image;
  final double gap;
  final bool? fromNetwork;
  const ImagesWithShadow(
      {super.key, required this.image, required this.gap, this.fromNetwork});

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
                    child: (fromNetwork == null || fromNetwork == false)
                        ? Image.asset(
                            image,
                            fit: BoxFit.contain, // Ajuste de la imagen
                          )
                        : Image.network(
                            image,
                            fit: BoxFit.contain,
                          )),
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
