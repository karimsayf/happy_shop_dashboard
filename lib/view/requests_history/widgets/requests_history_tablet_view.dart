import 'package:flutter/material.dart';

import 'requests_history_record.dart';

class RequestsHistoryTabletView extends StatelessWidget {
  const RequestsHistoryTabletView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        RequestsHistoryRecord(flag: true,)
      ],
    );
  }
}
