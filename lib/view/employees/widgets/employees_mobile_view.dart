import 'package:flutter/material.dart';

import 'employees_record.dart';

class EmployeesMobileView extends StatelessWidget {
  const EmployeesMobileView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        EmployeesRecord(flag: false,)
      ],
    );
  }
}
