import 'package:flutter/material.dart';

import 'widgets/edit_section_desktop_view.dart';
import 'widgets/edit_section_mobile_view.dart';

class EditSection extends StatelessWidget {
  final String pageState;
  const EditSection({super.key, required this.pageState});

  @override
  Widget build(BuildContext context) {
    return pageState == 'desktop' || pageState == 'tablet'
        ? const EditSectionDesktopView()
        : const EditSectionMobileView();
  }
}
