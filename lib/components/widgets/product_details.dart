import 'package:flutter/material.dart';

import '../../models/product.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            product.name,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            'Price: N${product.currentPrice}',
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Color.fromRGBO(36, 36, 36, 1.0)),
          ),
          const SizedBox(height: 8.0),
          Text(
            product.description,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
