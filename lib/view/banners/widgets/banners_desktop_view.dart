import 'package:flutter/material.dart';

import 'banners_record.dart';

class BannersDesktopView extends StatelessWidget {
  const BannersDesktopView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        BannersRecord(flag: true,)
      ],
    );
  }
}
