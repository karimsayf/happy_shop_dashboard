import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/custom_circular_progress_indicator.dart';
import '../../utilities/colors.dart';
import '../../utilities/size_utility.dart';
import '../../view_model/sections_view_model.dart';
import 'widgets/sections_desktop_view.dart';
import 'widgets/sections_mobile_view.dart';
import 'widgets/sections_tablet_view.dart';

class Sections extends StatefulWidget {
  final String pageState;
  const Sections({super.key, required this.pageState});

  @override
  State<Sections> createState() => _SectionsState();
}

class _SectionsState extends State<Sections> {
  late final sectionsViewModel = Provider.of<SectionsViewModel>(context);

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<SectionsViewModel>(context,listen: false).getSectionsHome(context,"0");
    },);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    if (sectionsViewModel.isSectionsHomeLoading) {
      return Center(
        child: Padding(
          padding: EdgeInsets.only(top: getSize(context).height * 0.4),
          child: const CustomCircularProgressIndicator(
              iosSize: 30, color: AppColors.mainColor),
        ),
      );
    } else {
      if (widget.pageState == "desktop") {
        return const SectionsDesktopView();
      } else if (widget.pageState == "tablet") {
        return const SectionsTabletView();
      } else {
        return const SectionsMobileView();
      }
    }
  }
}
