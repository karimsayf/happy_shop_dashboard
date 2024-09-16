import 'package:flutter/material.dart';

import 'products_record.dart';

class ProductsTabletView extends StatelessWidget {
  const ProductsTabletView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        ProductsRecord(flag: true,)
      ],
    );
  }
}
