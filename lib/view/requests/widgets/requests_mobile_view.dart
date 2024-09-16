import 'package:flutter/material.dart';

import 'requests_record.dart';


class RequestsMobileView extends StatelessWidget {
  const RequestsMobileView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        RequestsRecord(flag: false,)
      ],
    );
  }
}
