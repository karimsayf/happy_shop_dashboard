import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../components/custom_title.dart';
import '../../../components/main_drawer.dart';
import '../../../utilities/colors.dart';
import '../../../utilities/size_utility.dart';
import '../../../view_model/general_view_model.dart';
import '../../../view_model/user_view_model.dart';

class MainScreenDesktopView extends StatelessWidget {
  final Widget page;
  const MainScreenDesktopView({super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const MainDrawer(),
          Expanded(
              child: Column(
            children: [
              Container(
                height: 70,
                width: getSize(context).width,
                color: AppColors.c555,
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomTitle(
                      text: Provider.of<GeneralViewModel>(context,listen: true).mainTitle,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: AppColors.c016,
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
              Expanded(
                child: SingleChildScrollView(
                  child: page,
                ),
              ),
            ],
          ))
        ],
      ),
    );
  }
}
