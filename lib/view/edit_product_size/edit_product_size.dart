import 'package:flutter/material.dart';

import 'widgets/edit_product_size_desktop_view.dart';
import 'widgets/edit_product_size_mobile_view.dart';

class EditProductSize extends StatefulWidget {
  final String pageState;

  const EditProductSize({super.key, required this.pageState});

  @override
  State<EditProductSize> createState() => _EditProductSizeState();
}

class _EditProductSizeState extends State<EditProductSize> {
  @override
  Widget build(BuildContext context) {
    return widget.pageState == 'desktop' || widget.pageState == 'tablet'
        ? const EditProductSizeDesktopView()
        : const EditProductSizeMobileView();
  }
}
