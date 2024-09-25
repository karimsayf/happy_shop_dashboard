import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/custom_circular_progress_indicator.dart';
import '../../utilities/colors.dart';
import '../../utilities/size_utility.dart';
import '../../view_model/product_sizes_view_model.dart';
import '../../view_model/product_view_model.dart';
import 'widgets/product_sizes_desktop_view.dart';
import 'widgets/product_sizes_mobile_view.dart';
import 'widgets/product_sizes_tablet_view.dart';

class ProductSizes extends StatefulWidget {
  final String pageState;

  const ProductSizes({super.key, required this.pageState});

  @override
  State<ProductSizes> createState() => _ProductSizesState();
}

class _ProductSizesState extends State<ProductSizes> {
  late final sizeViewModel = Provider.of<ProductSizesViewModel>(context);

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        Provider.of<ProductSizesViewModel>(context, listen: false).getSizes(
            context,
            Provider.of<ProductViewModel>(context, listen: false).productSizes);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.pageState == "desktop") {
      return const ProductSizesDesktopView();
    } else if (widget.pageState == "tablet") {
      return const ProductSizesTabletView();
    } else {
      return const ProductSizesMobileView();
    }
  }
}
