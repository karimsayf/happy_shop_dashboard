import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utilities/constants.dart';
import '../view/auth/authentication.dart';
import '../view_model/general_view_model.dart';
import '../view_model/user_view_model.dart';
import 'custom_circular_progress_indicator.dart';
import 'custom_title.dart';
import '../utilities/colors.dart';
import '../utilities/size_utility.dart';
import 'custom_toast.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({super.key});

  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  bool signingOut = false;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.c555,
      surfaceTintColor: AppColors.c555,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      width: 280,
      child: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.only(start: 15),
                    child: Column(
                      children: [
                        const SizedBox(height: 5,),
                        Image.asset(
                          "assets/icons/app_logo.webp",
                          scale: 8.5,
                          color:   AppColors.mainColor

                        ),
                        SizedBox(height:10),
                        const CustomTitle(
                          text: "هابي شوب",
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.c000,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Row(
                    children: [
                      CustomTitle(
                        text: "القائمة",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.c912,
                      ),
                    ],
                  ),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        Provider.of<GeneralViewModel>(context, listen: false)
                            .updateMainScreen(HOME_INDEX, "الرئيسية");
                      },
                      child: Container(
                        height: 40,
                        width: getSize(context).width,
                        margin: const EdgeInsets.only(top: 15),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: Provider.of<GeneralViewModel>(context,
                                          listen: true)
                                      .selectedIndex ==
                                  HOME_INDEX
                              ? AppColors.mainColor.withOpacity(0.1)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/icons/element-4.webp",
                              scale: 4.5,
                              color: Provider.of<GeneralViewModel>(context,
                                              listen: true)
                                          .selectedIndex ==
                                      HOME_INDEX
                                  ? AppColors.mainColor
                                  : AppColors.c912,
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            CustomTitle(
                              text: "الرئيسية",
                              fontSize: 18,
                              fontWeight: Provider.of<GeneralViewModel>(context,
                                              listen: true)
                                          .selectedIndex ==
                                      HOME_INDEX
                                  ? FontWeight.w700
                                  : FontWeight.w400,
                              color: Provider.of<GeneralViewModel>(context,
                                              listen: true)
                                          .selectedIndex ==
                                      HOME_INDEX
                                  ? AppColors.mainColor
                                  : AppColors.c912,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        Provider.of<GeneralViewModel>(context, listen: false)
                            .updateMainScreen(BANNERS_INDEX, "البنرات");
                      },
                      child: Container(
                        height: 40,
                        width: getSize(context).width,
                        margin: const EdgeInsets.only(top: 15),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: Provider.of<GeneralViewModel>(context,
                              listen: true)
                              .selectedIndex ==
                              BANNERS_INDEX
                              ? AppColors.mainColor.withOpacity(0.1)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/icons/layer.webp",
                              scale: 4.5,
                              color: Provider.of<GeneralViewModel>(context,
                                  listen: true)
                                  .selectedIndex ==
                                  BANNERS_INDEX
                                  ? AppColors.mainColor
                                  : AppColors.c912,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            CustomTitle(
                              text: "البنرات",
                              fontSize: 18,
                              fontWeight: Provider.of<GeneralViewModel>(context,
                                  listen: true)
                                  .selectedIndex ==
                                  BANNERS_INDEX
                                  ? FontWeight.w700
                                  : FontWeight.w400,
                              color: Provider.of<GeneralViewModel>(context,
                                  listen: true)
                                  .selectedIndex ==
                                  BANNERS_INDEX
                                  ? AppColors.mainColor
                                  : AppColors.c912,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        Provider.of<GeneralViewModel>(context, listen: false)
                            .updateMainScreen(SECTIONS_INDEX, "الأقسام");
                      },
                      child: Container(
                        height: 40,
                        width: getSize(context).width,
                        margin: const EdgeInsets.only(top: 15),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: Provider.of<GeneralViewModel>(context,
                                          listen: true)
                                      .selectedIndex ==
                                  SECTIONS_INDEX
                              ? AppColors.mainColor.withOpacity(0.1)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/icons/layer.webp",
                              scale: 4.5,
                              color: Provider.of<GeneralViewModel>(context,
                                              listen: true)
                                          .selectedIndex ==
                                      SECTIONS_INDEX
                                  ? AppColors.mainColor
                                  : AppColors.c912,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            CustomTitle(
                              text: "الأقسام",
                              fontSize: 18,
                              fontWeight: Provider.of<GeneralViewModel>(context,
                                              listen: true)
                                          .selectedIndex ==
                                      SECTIONS_INDEX
                                  ? FontWeight.w700
                                  : FontWeight.w400,
                              color: Provider.of<GeneralViewModel>(context,
                                              listen: true)
                                          .selectedIndex ==
                                      SECTIONS_INDEX
                                  ? AppColors.mainColor
                                  : AppColors.c912,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        Provider.of<GeneralViewModel>(context, listen: false)
                            .updateMainScreen(PRODUCTS_INDEX, "المنتجات");
                      },
                      child: Container(
                        height: 40,
                        width: getSize(context).width,
                        margin: const EdgeInsets.only(top: 15),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: Provider.of<GeneralViewModel>(context,
                                          listen: true)
                                      .selectedIndex ==
                                  PRODUCTS_INDEX
                              ? AppColors.mainColor.withOpacity(0.1)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/icons/layer.webp",
                              scale: 4.5,
                              color: Provider.of<GeneralViewModel>(context,
                                              listen: true)
                                          .selectedIndex ==
                                      PRODUCTS_INDEX
                                  ? AppColors.mainColor
                                  : AppColors.c912,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            CustomTitle(
                              text: "المنتجات",
                              fontSize: 18,
                              fontWeight: Provider.of<GeneralViewModel>(context,
                                              listen: true)
                                          .selectedIndex ==
                                      PRODUCTS_INDEX
                                  ? FontWeight.w700
                                  : FontWeight.w400,
                              color: Provider.of<GeneralViewModel>(context,
                                              listen: true)
                                          .selectedIndex ==
                                      PRODUCTS_INDEX
                                  ? AppColors.mainColor
                                  : AppColors.c912,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        Provider.of<GeneralViewModel>(context, listen: false)
                            .updateMainScreen(CITY_INDEX, "مدن التوصيل");
                      },
                      child: Container(
                        height: 40,
                        width: getSize(context).width,
                        margin: const EdgeInsets.only(top: 15),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: Provider.of<GeneralViewModel>(context,
                              listen: true)
                              .selectedIndex ==
                              CITY_INDEX
                              ? AppColors.mainColor.withOpacity(0.1)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/icons/layer.webp",
                              scale: 4.5,
                              color: Provider.of<GeneralViewModel>(context,
                                  listen: true)
                                  .selectedIndex ==
                                  CITY_INDEX
                                  ? AppColors.mainColor
                                  : AppColors.c912,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            CustomTitle(
                              text: "التوصيل",
                              fontSize: 18,
                              fontWeight: Provider.of<GeneralViewModel>(context,
                                  listen: true)
                                  .selectedIndex ==
                                  CITY_INDEX
                                  ? FontWeight.w700
                                  : FontWeight.w400,
                              color: Provider.of<GeneralViewModel>(context,
                                  listen: true)
                                  .selectedIndex ==
                                  CITY_INDEX
                                  ? AppColors.mainColor
                                  : AppColors.c912,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        Provider.of<GeneralViewModel>(context, listen: false)
                            .updateMainScreen(EMPLOYEES_INDEX, "الموظفين");
                      },
                      child: Container(
                        height: 40,
                        width: getSize(context).width,
                        margin: const EdgeInsets.only(top: 15),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: Provider.of<GeneralViewModel>(context,
                                          listen: true)
                                      .selectedIndex ==
                                  EMPLOYEES_INDEX
                              ? AppColors.mainColor.withOpacity(0.1)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/icons/profile-2user.webp",
                              scale: 4.5,
                              color: Provider.of<GeneralViewModel>(context,
                                              listen: true)
                                          .selectedIndex ==
                                      EMPLOYEES_INDEX
                                  ? AppColors.mainColor
                                  : AppColors.c912,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            CustomTitle(
                              text: "الموظفين",
                              fontSize: 18,
                              fontWeight: Provider.of<GeneralViewModel>(context,
                                              listen: true)
                                          .selectedIndex ==
                                      EMPLOYEES_INDEX
                                  ? FontWeight.w700
                                  : FontWeight.w400,
                              color: Provider.of<GeneralViewModel>(context,
                                              listen: true)
                                          .selectedIndex ==
                                      EMPLOYEES_INDEX
                                  ? AppColors.mainColor
                                  : AppColors.c912,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        signOut();
                      },
                      child: Container(
                        height: 40,
                        width: getSize(context).width,
                        color: Colors.transparent,
                        margin: const EdgeInsets.only(top: 15),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  "assets/icons/logout.webp",
                                  scale: 4.5,
                                  fit: BoxFit.contain,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const CustomTitle(
                                  text: "تسجيل الخروج ",
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.c822,
                                ),
                              ],
                            ),
                            Visibility(
                              visible: signingOut,
                              replacement: const SizedBox(),
                              child: const CustomCircularProgressIndicator(
                                  iosSize: 30, color: AppColors.mainColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  signOut() async{
    setState(() {
      signingOut = true;
    });
    await Future.delayed(const Duration(milliseconds: 300)).then((_) async{
      await Provider.of<UserViewModel>(context, listen: false)
          .deleteUserData()
          .then((_) async {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const Authentication(),
          ),
              (route) => true,
        );
        setState(() {
          signingOut = false;
        });
      });
    },);

  }
}
