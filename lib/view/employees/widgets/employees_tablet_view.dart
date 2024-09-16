import 'package:flutter/material.dart';

import 'employees_record.dart';

class EmployeesTabletView extends StatelessWidget {
  const EmployeesTabletView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        EmployeesRecord(flag: true,)
      ],
    );
  }
}
