import 'package:bexmovil/src/presentation/widgets/atoms/app_card.dart';
import 'package:bexmovil/src/utils/extensions/string_extension.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

//domain
import '../../../../../domain/models/product.dart';
import '../../../../widgets/atoms/app_text.dart';

class CardProductPhotoSale extends StatelessWidget {
  final Product product;

  const CardProductPhotoSale({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return AppCard.filled(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          product.imagen != null
              ? CachedNetworkImage(
                  imageUrl: product.imagen!,
                  placeholder: (context, url) => const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Center(child: CircularProgressIndicator())),
                  errorWidget: (context, url, error) => Image.asset(
                      'assets/images/shopping_cart.png',
                      fit: BoxFit.fill),
                )
              : Image.asset('assets/images/shopping_cart.png',
                  fit: BoxFit.fill),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: AppText(
              maxLines: 2,
              fontSize: 12,
              product.nomProducto,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: AppText(''.formatted(product.precioProductoPrecio!),
                fontSize: 12),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: AppText(
              product.existenciaStock!.toString(),
              fontSize: 12,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
