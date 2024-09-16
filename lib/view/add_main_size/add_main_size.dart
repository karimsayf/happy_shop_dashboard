import 'package:flutter/material.dart';

import 'widgets/add_main_size_desktop_view.dart';
import 'widgets/add_main_size_mobile_view.dart';

class AddMainSize extends StatelessWidget {
  final String pageState;
  const AddMainSize({super.key, required this.pageState});

  @override
  Widget build(BuildContext context) {
    return pageState == 'desktop' || pageState == 'tablet'
        ? const AddMainSizeDesktopView()
        : const AddMainSizeMobileView();
  }
}
