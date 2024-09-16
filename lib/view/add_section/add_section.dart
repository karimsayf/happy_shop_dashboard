import 'package:flutter/material.dart';

import 'widgets/add_section_desktop_view.dart';
import 'widgets/add_section_mobile_view.dart';

class AddSection extends StatelessWidget {
  final String pageState;
  const AddSection({super.key, required this.pageState});

  @override
  Widget build(BuildContext context) {
    return pageState == 'desktop' || pageState == 'tablet'
        ? const AddSectionDesktopView()
        : const AddSectionMobileView();
  }
}
