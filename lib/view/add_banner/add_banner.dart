import 'package:flutter/material.dart';

import 'widgets/add_banner_desktop_view.dart';
import 'widgets/add_banner_mobile_view.dart';

class AddBanner extends StatelessWidget {
  final String pageState;
  const AddBanner({super.key, required this.pageState});

  @override
  Widget build(BuildContext context) {
    return pageState == 'desktop' || pageState == 'tablet'
        ? const AddBannerDesktopView()
        : const AddBannerMobileView();
  }
}
