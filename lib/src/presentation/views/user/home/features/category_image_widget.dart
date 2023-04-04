import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class CategoryImageWidget extends StatelessWidget {
  const CategoryImageWidget({Key? key, required this.image}) : super(key: key);

  final String image;

  Future<String> isLocalAsset(final String assetPath) async {
    final encoded = utf8.encoder.convert(Uri(path: Uri.encodeFull(assetPath)).path);
    final asset = await ServicesBinding.instance.defaultBinaryMessenger.send('flutter/assets', encoded.buffer.asByteData());
    return asset.toString();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        future: isLocalAsset(image),
        builder: (context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            return Opacity(opacity: 0.5, child: Image.asset(image, height: 170, width: 170));
          } else {
            return Container();
          }
        }
    );

  }
}
