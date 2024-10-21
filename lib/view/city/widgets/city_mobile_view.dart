import 'package:flutter/material.dart';

import 'city_record.dart';

class CityMobileView extends StatelessWidget {
  const CityMobileView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        CityRecord(flag: false,)
      ],
    );
  }
}
