import 'package:flutter/cupertino.dart';

import 'widgets/edit_product_desktop_view.dart';
import 'widgets/edit_product_mobile_view.dart';

class EditProduct extends StatelessWidget {
  final String pageState;
  const EditProduct({super.key, required this.pageState});

  @override
  Widget build(BuildContext context) {
    return pageState == 'desktop' || pageState == 'tablet'
        ? const EditProductDesktopView()
        : const EditProductMobileView();
  }
}
