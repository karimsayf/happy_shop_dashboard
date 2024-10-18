import 'package:flutter/material.dart';

import 'banners_record.dart';

class BannersTabletView extends StatelessWidget {
  const BannersTabletView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        BannersRecord(flag: true,)
      ],
    );
  }
}
