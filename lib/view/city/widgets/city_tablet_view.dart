import 'package:flutter/material.dart';

import 'city_record.dart';

class CityTabletView extends StatelessWidget {
  const CityTabletView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        CityRecord(flag: true,)
      ],
    );
  }
}
