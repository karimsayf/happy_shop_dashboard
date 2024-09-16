import 'package:flutter/material.dart';

import 'widgets/edit_employee_desktop_view.dart';
import 'widgets/edit_employee_mobile_view.dart';

class EditEmployee extends StatefulWidget {
  final String pageState;

  const EditEmployee({super.key, required this.pageState});

  @override
  State<EditEmployee> createState() => _EditEmployeeState();
}

class _EditEmployeeState extends State<EditEmployee> {
  @override
  Widget build(BuildContext context) {
    return widget.pageState == 'desktop' || widget.pageState == 'tablet'
        ? const EditEmployeeDesktopView()
        : const EditEmployeeMobileView();
  }
}
