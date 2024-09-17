import 'package:flutter/material.dart';

import 'widgets/add_product_size_desktop_view.dart';
import 'widgets/add_product_size_mobile_view.dart';

class AddProductSize extends StatefulWidget {
  final String pageState;

  const AddProductSize({super.key, required this.pageState});

  @override
  State<AddProductSize> createState() => _AddProductSizeState();
}

class _AddProductSizeState extends State<AddProductSize> {
  @override
  Widget build(BuildContext context) {
    return widget.pageState == 'desktop' || widget.pageState == 'tablet'
        ? const AddProductSizeDesktopView()
        : const AddProductSizeMobileView();
  }
}
