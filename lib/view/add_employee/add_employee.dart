import 'package:flutter/material.dart';

import 'widgets/add_employee_desktop_view.dart';
import 'widgets/add_employee_mobile_view.dart';

class AddEmployee extends StatefulWidget {
  final String pageState;

  const AddEmployee({super.key, required this.pageState});

  @override
  State<AddEmployee> createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  @override
  Widget build(BuildContext context) {
    return widget.pageState == 'desktop' || widget.pageState == 'tablet'
        ? const AddEmployeeDesktopView()
        : const AddEmployeeMobileView();
  }
}
