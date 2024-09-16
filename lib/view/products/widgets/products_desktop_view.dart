import 'package:flutter/material.dart';

import 'products_record.dart';

class ProductsDesktopView extends StatelessWidget {
  const ProductsDesktopView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        ProductsRecord(flag: true,)
      ],
    );
  }
}
