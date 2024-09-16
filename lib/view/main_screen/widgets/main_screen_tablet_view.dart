import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../components/custom_title.dart';
import '../../../components/main_drawer.dart';
import '../../../utilities/colors.dart';
import '../../../utilities/size_utility.dart';
import '../../../view_model/general_view_model.dart';
import '../../../view_model/user_view_model.dart';

class MainScreenTabletView extends StatelessWidget {
  final Widget page;
  const MainScreenTabletView({super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.c555,
        toolbarHeight: 60,
        leadingWidth: getSize(context).width,
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Builder(
                  builder: (BuildContext context) {
                    return IconButton(
                      icon: const Icon(
                        Icons.menu,
                        size: 28,
                        color: AppColors.c912,
                      ),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                    );
                  },
                ),
                CustomTitle(
                  text: Provider.of<GeneralViewModel>(context,listen: true).mainTitle,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: AppColors.c016,
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.c991),
              height: 45,
              padding:
              const EdgeInsetsDirectional.only(start: 10, end: 10),
              child: Center(
                child: CustomTitle(
                  text: Provider.of<UserViewModel>(context,listen: true).name,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: AppColors.c016,
                ),
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
          child: page),
      drawerEnableOpenDragGesture: false,
      drawer: const MainDrawer(),
    );
  }
}
