import 'package:flutter/material.dart';

import 'product_colors_record.dart';

class ProductColorsDesktopView extends StatelessWidget {
  const ProductColorsDesktopView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        ProductColorsRecord(flag: true,)
      ],
    );
  }
}
