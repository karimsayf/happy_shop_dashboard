import 'package:flutter/material.dart';

import 'banners_record.dart';

class BannersMobileView extends StatelessWidget {
  const BannersMobileView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        BannersRecord(flag: false,)
      ],
    );
  }
}
