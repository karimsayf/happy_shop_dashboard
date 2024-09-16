import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/custom_circular_progress_indicator.dart';
import '../../utilities/colors.dart';
import '../../utilities/size_utility.dart';
import '../../view_model/requests_view_model.dart';
import 'widgets/requests_desktop_view.dart';
import 'widgets/requests_mobile_view.dart';
import 'widgets/requests_tablet_view.dart';

class Requests extends StatefulWidget {
  final String pageState;
  const Requests({super.key, required this.pageState});

  @override
  State<Requests> createState() => _RequestsState();
}

class _RequestsState extends State<Requests> {
  late final requestViewModel = Provider.of<RequestsViewModel>(context);

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<RequestsViewModel>(context,listen: false).getRequestsHome(context,"0");
    },);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (requestViewModel.isRequestsHomeLoading) {
      return Padding(
        padding: EdgeInsets.only(top: getSize(context).height * 0.4),
        child: const CustomCircularProgressIndicator(
            iosSize: 30, color: AppColors.mainColor),
      );
    } else {
      if (widget.pageState == "desktop") {
        return const RequestsDesktopView();
      } else if (widget.pageState == "tablet") {
        return const RequestsTabletView();
      } else {
        return const RequestsMobileView();
      }
    }
  }
}

