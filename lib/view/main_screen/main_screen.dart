import 'package:flutter/material.dart';
import 'package:menu_dashboard/view/add_banner/add_banner.dart';
import 'package:menu_dashboard/view/add_prodcut_color/add_product_color.dart';
import 'package:menu_dashboard/view/add_product_size/add_product_size.dart';
import 'package:menu_dashboard/view/banners/banners.dart';
import 'package:menu_dashboard/view/edit_banner/edit_banner.dart';
import 'package:menu_dashboard/view/product_colors/product_colors.dart';
import 'package:menu_dashboard/view/products/products.dart';
import 'package:menu_dashboard/view/requests_history/requests_history.dart';
import 'package:provider/provider.dart';

import '../../utilities/constants.dart';
import '../../view_model/auth_form_provider.dart';
import '../../view_model/general_view_model.dart';
import '../add_employee/add_employee.dart';
import '../add_product/add_product.dart';
import '../add_section/add_section.dart';
import '../edit_employee/edit_employee.dart';
import '../edit_product/edit_product.dart';
import '../edit_section/edit_section.dart';
import '../employees/employees.dart';
import '../product_sizes/product_sizes.dart';
import '../requests/requests.dart';
import '../responsive/responsive_layout.dart';
import '../sections/sections.dart';
import 'widgets/main_screen_desktop_view.dart';
import 'widgets/main_screen_mobile_view.dart';
import 'widgets/main_screen_tablet_view.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) =>
          Provider.of<AuthFormProvider>(context, listen: false).clearData(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ResponsiveLayout(
            mobile: MainScreenMobileView(
              page: mainPage(context, "mobile"),
            ),
            tablet: MainScreenTabletView(
              page: mainPage(context, "tablet"),
            ),
            desktop: MainScreenDesktopView(
              page: mainPage(context, "desktop"),
            )));
  }

  Widget mainPage(BuildContext context, String pageState) {
    if (Provider.of<GeneralViewModel>(context, listen: true).selectedIndex ==
        HOME_INDEX) {
      return Requests(pageState: pageState);
    } else if (Provider.of<GeneralViewModel>(context, listen: true)
            .selectedIndex ==
        SECTIONS_INDEX) {
      return Sections(pageState: pageState);
    } else if (Provider.of<GeneralViewModel>(context, listen: true)
            .selectedIndex ==
        PRODUCTS_INDEX) {
      return Products(pageState: pageState);
    } else if (Provider.of<GeneralViewModel>(context, listen: true)
            .selectedIndex ==
        EMPLOYEES_INDEX) {
      return Employees(pageState: pageState);
    } else if (Provider.of<GeneralViewModel>(context, listen: true)
            .selectedIndex ==
        ADDSECTIONS_INDEX) {
      return AddSection(pageState: pageState);
    } else if (Provider.of<GeneralViewModel>(context, listen: true)
        .selectedIndex ==
        EDITSECTIONS_INDEX) {
      return EditSection(pageState: pageState);
    }  else if (Provider.of<GeneralViewModel>(context, listen: true)
        .selectedIndex ==
        ADDPRODUCT_INDEX) {
      return AddProduct(pageState: pageState);
    } else if (Provider.of<GeneralViewModel>(context, listen: true)
        .selectedIndex ==
        EDITPRODUCT_INDEX) {
      return EditProduct(pageState: pageState);
    } else if (Provider.of<GeneralViewModel>(context, listen: true)
            .selectedIndex ==
        ADDEMPLOYEE_INDEX) {
      return AddEmployee(pageState: pageState);
    } else if (Provider.of<GeneralViewModel>(context, listen: true)
            .selectedIndex ==
        EDITEMPLOYEE_INDEX) {
      return EditEmployee(pageState: pageState);
    } else if (Provider.of<GeneralViewModel>(context, listen: true)
        .selectedIndex ==
        SIZES_INDEX) {
      return ProductSizes(pageState: pageState);
    } else if (Provider.of<GeneralViewModel>(context, listen: true)
        .selectedIndex ==
        ADDSIZE_INDEX) {
      return AddProductSize(pageState: pageState);
    } else if (Provider.of<GeneralViewModel>(context, listen: true)
        .selectedIndex ==
        ORDERSHISTORY_INDEX) {
      return RequestsHistory(pageState: pageState);
    }else if (Provider.of<GeneralViewModel>(context, listen: true)
        .selectedIndex ==
        BANNERS_INDEX) {
      return Banners(pageState: pageState);
    }else if (Provider.of<GeneralViewModel>(context, listen: true)
        .selectedIndex ==
        ADDBANNERS_INDEX) {
      return AddBanner(pageState: pageState);
    }else if (Provider.of<GeneralViewModel>(context, listen: true)
        .selectedIndex ==
        EDITBANNERS_INDEX) {
      return EditBanner(pageState: pageState);
    }else if (Provider.of<GeneralViewModel>(context, listen: true)
        .selectedIndex ==
        COLORS_INDEX) {
      return ProductColors(pageState: pageState);
    }else if (Provider.of<GeneralViewModel>(context, listen: true)
        .selectedIndex ==
        ADDCOLOR_INDEX) {
      return AddProductColor(pageState: pageState);
    }
    return const SizedBox();
  }
}
