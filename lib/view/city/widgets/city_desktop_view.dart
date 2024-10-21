import 'package:flutter/material.dart';

import 'city_record.dart';

class CityDesktopView extends StatelessWidget {
  const CityDesktopView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        CityRecord(flag: true,)
      ],
    );
  }
}
