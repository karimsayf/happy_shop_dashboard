import 'package:flutter/material.dart';

import 'products_record.dart';

class ProductsMobileView extends StatelessWidget {
  const ProductsMobileView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        ProductsRecord(flag: true,)
      ],
    );
  }
}
