import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/custom_circular_progress_indicator.dart';
import '../../utilities/colors.dart';
import '../../utilities/size_utility.dart';
import '../../view_model/product_view_model.dart';
import 'widgets/products_desktop_view.dart';
import 'widgets/products_mobile_view.dart';
import 'widgets/products_tablet_view.dart';

class Products extends StatefulWidget {
  final String pageState;
  const Products({super.key, required this.pageState});

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  late final productViewModel = Provider.of<ProductViewModel>(context);

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ProductViewModel>(context,listen: false).getProductsHome(context,"0");
    },);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (productViewModel.isProductsHomeLoading) {
      return Padding(
        padding: EdgeInsets.only(top: getSize(context).height * 0.4),
        child: const CustomCircularProgressIndicator(
            iosSize: 30, color: AppColors.mainColor),
      );
    } else {
      if (widget.pageState == "desktop") {
        return const ProductsDesktopView();
      } else if (widget.pageState == "tablet") {
        return const ProductsTabletView();
      } else {
        return const ProductsMobileView();
      }
    }
  }
}
