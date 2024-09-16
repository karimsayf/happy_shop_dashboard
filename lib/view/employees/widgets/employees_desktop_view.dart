import 'package:flutter/material.dart';

import 'employees_record.dart';

class EmployeesDesktopView extends StatelessWidget {
  const EmployeesDesktopView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        EmployeesRecord(flag: true,)
      ],
    );
  }
}
