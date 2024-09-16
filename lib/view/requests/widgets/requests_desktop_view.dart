import 'package:flutter/material.dart';

import 'requests_record.dart';

class RequestsDesktopView extends StatelessWidget {
  const RequestsDesktopView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        RequestsRecord(flag: true,)
      ],
    );
  }
}
