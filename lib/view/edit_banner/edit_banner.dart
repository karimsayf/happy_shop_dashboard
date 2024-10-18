import 'package:flutter/material.dart';

import 'widgets/edit_banner_desktop_view.dart';
import 'widgets/edit_banner_mobile_view.dart';

class EditBanner extends StatelessWidget {
  final String pageState;
  const EditBanner({super.key, required this.pageState});

  @override
  Widget build(BuildContext context) {
    return pageState == 'desktop' || pageState == 'tablet'
        ? const EditBannerDesktopView()
        : const EditBannerMobileView();
  }
}
