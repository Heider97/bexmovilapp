import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

//domain
import '../../../../../domain/models/product.dart';

//utils
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/nums.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget({Key? key, required this.product}) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: productHeight,
        child: Row(
          children: [
            Padding(
                padding: const EdgeInsets.all(10),
                child: CircleAvatar(
                  radius: 50,
                  child: CachedNetworkImage(
                    width: double.infinity,
                    height: 100.0,
                    imageUrl: product.image,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                )),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.name,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  Text(product.description,
                      maxLines: 2, style: const TextStyle(fontSize: 11)),
                  const SizedBox(height: 5),
                  Text('\$${product.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                          color: kPrimaryColor, fontWeight: FontWeight.bold))
                ],
              ),
            )
          ],
        ));
  }
}
