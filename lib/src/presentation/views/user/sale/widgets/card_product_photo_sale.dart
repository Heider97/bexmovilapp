import 'package:flutter/material.dart';

//domain
import '../../../../../domain/models/product.dart';

class CardProductPhotoSale extends StatelessWidget {
  final Product product;

  const CardProductPhotoSale({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(product.imagen!),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              product.nomProducto,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(product.precioProductoPrecio!.toString()),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Text(
              product.existenciaStock!.toString(),
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
