import 'package:flutter/material.dart';

import 'sections_record.dart';

class SectionsMobileView extends StatelessWidget {
  const SectionsMobileView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SectionsRecord(flag: true,)
      ],
    );
  }
}
