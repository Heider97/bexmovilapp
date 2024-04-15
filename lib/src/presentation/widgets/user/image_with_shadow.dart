import 'package:bexmovil/src/utils/constants/strings.dart';
import 'package:bexmovil/src/utils/resources/app_dialogs.dart';
import 'package:flutter/material.dart';

class ImagesWithShadow extends StatelessWidget {
  final String image;
  final double gap;
  final bool? fromNetwork;
  final double? heightShadow;
  const ImagesWithShadow(
      {super.key,
      required this.image,
      required this.gap,
      this.fromNetwork,
      this.heightShadow});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        /*  showCarouselImageDialog(context: context, productImagesList: [image,image,image,image]); */
        showDialog(
          context: context,
          builder: (_) => CarouselImageDialog(
              productImagesList: [image, image, image, image]),
        );
      },
      child: SizedBox(
        child: ClipRect(
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
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
                    height: heightShadow,
                    Assets.shadow,
                    fit: BoxFit.fitHeight, // Ajuste de la imagen
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
