import 'package:flutter/material.dart';
import 'package:menu_dashboard/view_model/city_view_model.dart';
import 'package:provider/provider.dart';

import '../../components/custom_circular_progress_indicator.dart';
import '../../utilities/colors.dart';
import '../../utilities/size_utility.dart';
import '../../view_model/employees_view_model.dart';
import 'widgets/city_desktop_view.dart';
import 'widgets/city_mobile_view.dart';
import 'widgets/city_tablet_view.dart';

class Cities extends StatefulWidget {
  final String pageState;
  const Cities({super.key, required this.pageState});

  @override
  State<Cities> createState() => _CitiesState();
}

class _CitiesState extends State<Cities> {
  late final cityViewModel = Provider.of<CityViewModel>(context);

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<CityViewModel>(context,listen: false).getCityHome(context,);
    },);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (cityViewModel.isCityHomeLoading) {
      return Center(
        child: Padding(
          padding: EdgeInsets.only(top: getSize(context).height * 0.4),
          child: const CustomCircularProgressIndicator(
              iosSize: 30, color: AppColors.mainColor),
        ),
      );
    } else {
      if (widget.pageState == "desktop") {
        return const CityDesktopView();
      } else if (widget.pageState == "tablet") {
        return const CityTabletView();
      } else {
        return const CityMobileView();
      }
    }
  }
}
