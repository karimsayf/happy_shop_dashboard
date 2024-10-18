import 'package:flutter/material.dart';

import 'product_colors_record.dart';

class ProductColorsMobileView extends StatelessWidget {
  const ProductColorsMobileView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        ProductColorsRecord(flag: false,)
      ],
    );
  }
}
