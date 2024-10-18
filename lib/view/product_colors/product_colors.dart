import 'package:flutter/material.dart';
import 'package:menu_dashboard/view_model/product_colors_view_model.dart';
import 'package:provider/provider.dart';

import '../../components/custom_circular_progress_indicator.dart';
import '../../utilities/colors.dart';
import '../../utilities/size_utility.dart';
import '../../view_model/product_sizes_view_model.dart';
import '../../view_model/product_view_model.dart';
import 'widgets/product_colors_desktop_view.dart';
import 'widgets/product_colors_mobile_view.dart';
import 'widgets/product_colors_tablet_view.dart';

class ProductColors extends StatefulWidget {
  final String pageState;

  const ProductColors({super.key, required this.pageState});

  @override
  State<ProductColors> createState() => _ProductColorsState();
}

class _ProductColorsState extends State<ProductColors> {
  late final colorViewModel = Provider.of<ProductColorsViewModel>(context);

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        Provider.of<ProductColorsViewModel>(context, listen: false).getProductColorsHome(
            context,
            Provider.of<ProductViewModel>(context, listen: false).selectedProductId);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (colorViewModel.isColorsHomeLoading) {
      return Padding(
        padding: EdgeInsets.only(top: getSize(context).height * 0.4),
        child: const CustomCircularProgressIndicator(
            iosSize: 30, color: AppColors.mainColor),
      );
    } else {
      if (widget.pageState == "desktop") {
        return const ProductColorsDesktopView();
      } else if (widget.pageState == "tablet") {
        return const ProductColorsTabletView();
      } else {
        return const ProductColorsMobileView();
      }
    }
  }
}
