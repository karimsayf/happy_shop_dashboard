import 'package:flutter/material.dart';

import 'product_sizes_record.dart';

class ProductSizesTabletView extends StatelessWidget {
  const ProductSizesTabletView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        ProductSizesRecord(flag: true,)
      ],
    );
  }
}
