import 'package:flutter/material.dart';

import 'sections_record.dart';

class SectionsTabletView extends StatelessWidget {
  const SectionsTabletView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SectionsRecord(flag: true,)
      ],
    );
  }
}
