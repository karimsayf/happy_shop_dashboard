import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/custom_circular_progress_indicator.dart';
import '../../utilities/colors.dart';
import '../../utilities/size_utility.dart';
import '../../view_model/requests_view_model.dart';
import 'widgets/requests_history_desktop_view.dart';
import 'widgets/requests_history_mobile_view.dart';
import 'widgets/requests_history_tablet_view.dart';

class RequestsHistory extends StatefulWidget {
  final String pageState;
  const RequestsHistory({super.key, required this.pageState});

  @override
  State<RequestsHistory> createState() => _RequestsHistoryState();
}

class _RequestsHistoryState extends State<RequestsHistory> {
  late final requestViewModel = Provider.of<RequestsViewModel>(context);

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<RequestsViewModel>(context,listen: false).getRequestsHome(context, "DONE&CANCELLED", "0");
    },);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (requestViewModel.isRequestsHomeLoading) {
      return Center(
        child: Padding(
          padding: EdgeInsets.only(top: getSize(context).height * 0.4),
          child: const CustomCircularProgressIndicator(
              iosSize: 30, color: AppColors.mainColor),
        ),
      );
    } else {
      if (widget.pageState == "desktop") {
        return const RequestsHistoryDesktopView();
      } else if (widget.pageState == "tablet") {
        return const RequestsHistoryTabletView();
      } else {
        return const RequestsHistoryMobileView();
      }
    }
  }
}

