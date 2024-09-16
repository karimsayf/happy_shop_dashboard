import 'package:flutter/material.dart';

import 'widgets/add_product_desktop_view.dart';
import 'widgets/add_product_mobile_view.dart';

class AddProduct extends StatelessWidget {
  final String pageState;
  const AddProduct({super.key, required this.pageState});

  @override
  Widget build(BuildContext context) {
    return pageState == 'desktop' || pageState == 'tablet'
        ? const AddProductDesktopView()
        : const AddProductMobileView();
  }
}
