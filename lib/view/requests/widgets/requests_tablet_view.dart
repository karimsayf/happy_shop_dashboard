import 'package:flutter/material.dart';

import 'requests_record.dart';

class RequestsTabletView extends StatelessWidget {
  const RequestsTabletView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        RequestsRecord(flag: true,)
      ],
    );
  }
}
