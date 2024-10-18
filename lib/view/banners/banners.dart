import 'package:flutter/material.dart';
import 'package:menu_dashboard/view_model/banners_view_model.dart';
import 'package:provider/provider.dart';

import '../../components/custom_circular_progress_indicator.dart';
import '../../utilities/colors.dart';
import '../../utilities/size_utility.dart';
import '../../view_model/sections_view_model.dart';
import 'widgets/banners_desktop_view.dart';
import 'widgets/banners_mobile_view.dart';
import 'widgets/banners_tablet_view.dart';

class Banners extends StatefulWidget {
  final String pageState;
  const Banners({super.key, required this.pageState});

  @override
  State<Banners> createState() => _BannersState();
}

class _BannersState extends State<Banners> {
  late final bannersViewModel = Provider.of<BannersViewModel>(context);

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<BannersViewModel>(context,listen: false).getBannersHome(context,"0");
    },);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    if (bannersViewModel.isBannersHomeLoading) {
      return Center(
        child: Padding(
          padding: EdgeInsets.only(top: getSize(context).height * 0.4),
          child: const CustomCircularProgressIndicator(
              iosSize: 30, color: AppColors.mainColor),
        ),
      );
    } else {
      if (widget.pageState == "desktop") {
        return const BannersDesktopView();
      } else if (widget.pageState == "tablet") {
        return const BannersTabletView();
      } else {
        return const BannersMobileView();
      }
    }
  }
}
