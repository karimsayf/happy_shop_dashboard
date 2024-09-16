import 'package:flutter/material.dart';

import 'sections_record.dart';

class SectionsDesktopView extends StatelessWidget {
  const SectionsDesktopView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SectionsRecord(flag: true,)
      ],
    );
  }
}
