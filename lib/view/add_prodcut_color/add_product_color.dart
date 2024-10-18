import 'package:flutter/material.dart';

import 'widgets/add_product_color_desktop_view.dart';
import 'widgets/add_product_color_mobile_view.dart';

class AddProductColor extends StatefulWidget {
  final String pageState;

  const AddProductColor({super.key, required this.pageState});

  @override
  State<AddProductColor> createState() => _AddProductColorState();
}

class _AddProductColorState extends State<AddProductColor> {
  @override
  Widget build(BuildContext context) {
    return widget.pageState == 'desktop' || widget.pageState == 'tablet'
        ? const AddProductColorDesktopView()
        : const AddProductColorMobileView();
  }
}
