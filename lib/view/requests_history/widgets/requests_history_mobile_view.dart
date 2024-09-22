import 'package:flutter/material.dart';

import 'requests_history_record.dart';


class RequestsHistoryMobileView extends StatelessWidget {
  const RequestsHistoryMobileView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        RequestsHistoryRecord(flag: false,)
      ],
    );
  }
}
