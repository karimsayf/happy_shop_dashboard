import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/custom_circular_progress_indicator.dart';
import '../../utilities/colors.dart';
import '../../utilities/size_utility.dart';
import '../../view_model/employees_view_model.dart';
import 'widgets/employees_desktop_view.dart';
import 'widgets/employees_mobile_view.dart';
import 'widgets/employees_tablet_view.dart';

class Employees extends StatefulWidget {
  final String pageState;
  const Employees({super.key, required this.pageState});

  @override
  State<Employees> createState() => _EmployeesState();
}

class _EmployeesState extends State<Employees> {
  late final employeesViewModel = Provider.of<EmployeesViewModel>(context);

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<EmployeesViewModel>(context,listen: false).getEmployeesHome(context,"0");
    },);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (employeesViewModel.isEmployeesHomeLoading) {
      return Center(
        child: Padding(
          padding: EdgeInsets.only(top: getSize(context).height * 0.4),
          child: const CustomCircularProgressIndicator(
              iosSize: 30, color: AppColors.mainColor),
        ),
      );
    } else {
      if (widget.pageState == "desktop") {
        return const EmployeesDesktopView();
      } else if (widget.pageState == "tablet") {
        return const EmployeesTabletView();
      } else {
        return const EmployeesMobileView();
      }
    }
  }
}
