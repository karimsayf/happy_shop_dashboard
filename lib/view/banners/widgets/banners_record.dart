import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:menu_dashboard/view_model/add_banner_view_model.dart';
import 'package:menu_dashboard/view_model/banners_view_model.dart';
import 'package:menu_dashboard/view_model/edit_banner_view_model.dart';
import 'package:provider/provider.dart';

import '../../../components/custom_circular_progress_indicator.dart';
import '../../../components/custom_dialog.dart';
import '../../../components/custom_text_filed.dart';
import '../../../components/custom_title.dart';
import '../../../utilities/colors.dart';
import '../../../utilities/constants.dart';
import '../../../utilities/size_utility.dart';
import '../../../view_model/add_section_view_model.dart';
import '../../../view_model/general_view_model.dart';

class BannersRecord extends StatefulWidget {
  final bool flag;
  const BannersRecord({super.key, required this.flag});

  @override
  State<BannersRecord> createState() => _BannersRecordState();
}

class _BannersRecordState extends State<BannersRecord> {
  late final bannersViewModel = Provider.of<BannersViewModel>(context);


  @override
  Widget build(BuildContext context) {
    int totalRows = bannersViewModel.totalSections;
    int totalPages = (totalRows / bannersViewModel.rowsPerPage).ceil();

    void handlePrevious() {
      setState(() {
        bannersViewModel.currentPage--;
        bannersViewModel.firstNum = bannersViewModel.firstNum - 10;
        bannersViewModel.lastNum = bannersViewModel.lastNum - 10;
      });
      Provider.of<BannersViewModel>(context, listen: false)
          .getBanners(context, bannersViewModel.currentPage.toString(),false);
    }

    void handleNext() {
      setState(() {
        bannersViewModel.currentPage++;
        bannersViewModel.firstNum = bannersViewModel.firstNum + 10;
        bannersViewModel.lastNum = bannersViewModel.lastNum + 10;
      });
      Provider.of<BannersViewModel>(context, listen: false)
          .getBanners(context, bannersViewModel.currentPage.toString(),false);
    }

    List<DataRow> getRows() {
      List pageData = bannersViewModel.banners;
      return pageData.mapIndexed((index, banner) {
        return DataRow(cells: [
          DataCell(CustomTitle(
            text: (bannersViewModel.firstNum + index).toString(),
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.c016,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          )),
          DataCell(
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                "$baseUrl/uploads/${banner['photo']}",
                errorBuilder: (context, error, stackTrace) => Container(
                  decoration: BoxDecoration(
                    color: AppColors.c912.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  height: 40,
                  width: 40,
                ),
                height: 40,
                width: 40,
                fit: BoxFit.cover,
              ),
            ),
          ),
          DataCell(
            Row(
              children: [

                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Tooltip(
                    message: "تعديل",
                    enableTapToDismiss: true,
                    textAlign: TextAlign.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.c555,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.c016.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    preferBelow: false,
                    textStyle: const TextStyle(
                        fontFamily: stcFontStr,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.c244),
                    child: GestureDetector(
                      onTap: () {
                        Provider.of<EditBannerViewModel>(context, listen: false)
                            .clearData();
                        Provider.of<EditBannerViewModel>(context, listen: false)
                            .assignData(banner['photo'], banner['_id']);
                        Provider.of<GeneralViewModel>(context, listen: false)
                            .updateSelectedIndex(index: EDITBANNERS_INDEX);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColors.c074.withOpacity(0.1),
                        ),
                        height: 30,
                        width: 30,
                        child: Center(
                          child: Image.asset(
                            "assets/icons/edit-2.webp",
                            scale: 4.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      showCustomDialog(context, content: StatefulBuilder(
                        builder: (context, setState) {
                          return SizedBox(
                            width: 400,
                            height: 205,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: AppColors.c752.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(50)),
                                  child: Container(
                                    margin: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: AppColors.c555,
                                        borderRadius:
                                        BorderRadius.circular(50)),
                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                          color:
                                          AppColors.c752.withOpacity(0.11),
                                          borderRadius:
                                          BorderRadius.circular(50)),
                                      child: Center(
                                        child: Image.asset(
                                          "assets/icons/alert-circle.webp",
                                          scale: 3.5,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const CustomTitle(
                                  text: "حذف البانر",
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.c016,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const CustomTitle(
                                  text:
                                  "هل أنت متأكد أنك تريد حذف هذا البانر ؟ لا يمكن التراجع عن هذا الإجراء.",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.c912,
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: MouseRegion(
                                        cursor: SystemMouseCursors.click,
                                        child: GestureDetector(
                                          onTap: () => Navigator.pop(context),
                                          child: Container(
                                            height: 50,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(12),
                                                color: AppColors.c555,
                                                border: Border.all(
                                                    width: 1,
                                                    color: AppColors.c565)),
                                            child: const Center(
                                              child: CustomTitle(
                                                text: "إلغاء",
                                                fontSize: 20,
                                                fontWeight: FontWeight.w700,
                                                color: AppColors.c016,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                      child: MouseRegion(
                                        cursor: SystemMouseCursors.click,
                                        child: GestureDetector(
                                          onTap: bannersViewModel.deleting
                                              ? () {}
                                              : () async {
                                            await Provider.of<
                                                BannersViewModel>(
                                                context,
                                                listen: false)
                                                .deleteBanner(
                                              context,
                                              banner['_id'],
                                            );
                                          },
                                          child: Container(
                                            height: 50,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(12),
                                                color: AppColors.c4221,
                                                border: Border.all(
                                                    width: 1,
                                                    color: AppColors.c4221)),
                                            child: Center(
                                              child: Provider.of<
                                                  BannersViewModel>(
                                                  context)
                                                  .deleting
                                                  ? const CustomCircularProgressIndicator(
                                                  iosSize: 30,
                                                  color: AppColors.c555)
                                                  : const CustomTitle(
                                                text: "حذف",
                                                fontSize: 20,
                                                fontWeight:
                                                FontWeight.w700,
                                                color: AppColors.c555,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      ));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColors.c4221.withOpacity(0.1),
                      ),
                      height: 30,
                      width: 30,
                      child: Center(
                        child: Image.asset(
                          "assets/icons/trash.webp",
                          scale: 4.5,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]);
      }).toList();
    }

    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: AppColors.c555),
      padding: const EdgeInsets.symmetric(vertical: 20),
      margin: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            children: [
              const SizedBox(width: 10,),
              IconButton(onPressed: (){
                Provider.of<GeneralViewModel>(context,listen: false).updateSelectedIndex(index: HOME_INDEX);
              }, icon: const Icon(Icons.home,color: AppColors.mainColor,size: 20,),),
              const Text('/',style: TextStyle(color: AppColors.mainColor,fontSize: 13),),
              const SizedBox(width: 10,),
              const Text('البنرات',style: TextStyle(color: Colors.grey,fontSize: 13),),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: widget.flag
                ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CustomTitle(
                  text: "سجل البنرات",
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.c016,
                ),
                Row(
                  children: [
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () {
                          Provider.of<AddBannerViewModel>(context,listen: false).clearData();
                          Provider.of<GeneralViewModel>(context, listen: false)
                              .updateSelectedIndex(index: ADDBANNERS_INDEX);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.mainColor,
                          ),
                          height: 45,
                          width: 160,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add,
                                size: 18,
                                color: AppColors.c555,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              CustomTitle(
                                text: "إضافة بانر",
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: AppColors.c555,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            )
                : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomTitle(
                  text: "سجل البنرات",
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.c016,
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [

                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () {
                          Provider.of<AddBannerViewModel>(context,listen: false).clearData();
                          Provider.of<GeneralViewModel>(context, listen: false)
                              .updateSelectedIndex(index: ADDBANNERS_INDEX);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.mainColor,
                          ),
                          height: 45,
                          width: 160,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add,
                                size: 18,
                                color: AppColors.c555,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              CustomTitle(
                                text: "إضافة بانر",
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: AppColors.c555,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          if (widget.flag || bannersViewModel.bannersEmpty)
            SizedBox(
              width: getSize(context).width,
              child: buildDataTableTheme(getRows),
            )
          else
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                  width: getSize(context).width * 0.91,
                  child: buildDataTableTheme(getRows)),
            ),
          if (bannersViewModel.isBannersLoading)
            const Padding(
              padding: EdgeInsets.only(top: 20),
              child: CustomCircularProgressIndicator(
                  iosSize: 30, color: AppColors.mainColor),
            )
          else if (!bannersViewModel.bannersEmpty)
            Padding(
              padding:
              const EdgeInsetsDirectional.only(start: 20, end: 15, top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: "عرض ",
                      style: const TextStyle(
                          fontFamily: stcFontStr,
                          color: AppColors.c912,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                      children: <TextSpan>[
                        TextSpan(
                          text: "${bannersViewModel.firstNum}",
                          style: const TextStyle(
                              fontFamily: stcFontStr,
                              fontWeight: FontWeight.w500,
                              color: AppColors.c016,
                              fontSize: 14),
                        ),
                        const TextSpan(
                          text: " - ",
                          style: TextStyle(
                              fontFamily: stcFontStr,
                              fontWeight: FontWeight.w500,
                              color: AppColors.c016,
                              fontSize: 14),
                        ),
                        TextSpan(
                          text: "${bannersViewModel.lastNum}",
                          style: const TextStyle(
                              fontFamily: stcFontStr,
                              fontWeight: FontWeight.w500,
                              color: AppColors.c016,
                              fontSize: 14),
                        ),
                        const TextSpan(
                          text: " من ",
                          style: TextStyle(
                              fontFamily: stcFontStr,
                              fontWeight: FontWeight.w500,
                              color: AppColors.c912,
                              fontSize: 14),
                        ),
                        TextSpan(
                          text: "$totalRows",
                          style: const TextStyle(
                              fontFamily: stcFontStr,
                              fontWeight: FontWeight.w500,
                              color: AppColors.c016,
                              fontSize: 14),
                        ),
                        const TextSpan(
                          text: " نتيجة",
                          style: TextStyle(
                              fontFamily: stcFontStr,
                              fontWeight: FontWeight.w500,
                              color: AppColors.c912,
                              fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: bannersViewModel.currentPage > 0
                              ? handlePrevious
                              : null,
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.arrow_back_ios_rounded,
                              size: 25,
                              color: AppColors.c912,
                            ),
                          ),
                        ),
                      ),
                      if (totalPages <=
                          3) // If total pages are less than or equal to 3, display all page numbers
                        for (int i = 0; i < totalPages; i++)
                          buildPaginationButton(i, (value) {
                            if (value) {
                              setState(() {
                                bannersViewModel.firstNum =
                                    bannersViewModel.currentPage * 10 + 1;
                                bannersViewModel.lastNum =
                                    (bannersViewModel.currentPage + 1) * 10;
                              });
                            }
                          }),
                      if (totalPages > 3)
                        ...buildPaginationButtons(totalPages, (value) {
                          if (value) {
                            setState(() {
                              bannersViewModel.firstNum =
                                  bannersViewModel.currentPage * 10 + 1;
                              bannersViewModel.lastNum =
                                  (bannersViewModel.currentPage + 1) * 10;
                            });
                          }
                        }),
                      const SizedBox(
                        width: 10,
                      ),
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: bannersViewModel.currentPage < totalPages - 1
                              ? handleNext
                              : null,
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(12)),
                            child: const Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 25,
                              color: AppColors.c912,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          else if (bannersViewModel.bannersEmpty)
              const Padding(
                padding: EdgeInsets.only(top: 20),
                child: CustomTitle(
                  text: "لا توجد بنرات",
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: AppColors.c912,
                ),
              ),
        ],
      ),
    );
  }



  DataTableTheme buildDataTableTheme(List<DataRow> Function() getRows) {
    return DataTableTheme(
      data: DataTableThemeData(
        headingRowColor: WidgetStateProperty.all(AppColors.c790),
        dataRowColor: WidgetStateProperty.all(AppColors.c555),
        headingTextStyle: const TextStyle(
            color: AppColors.c912,
            fontWeight: FontWeight.w400,
            fontSize: 14,
            fontFamily: stcFontStr),
        dividerThickness: 0,
      ),
      child: DataTable(
        columns: const <DataColumn>[
          DataColumn(
            label: CustomTitle(
              text: "#",
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.c912,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          DataColumn(
            label: CustomTitle(
              text: "صورة البانر",
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.c912,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          DataColumn(
            label: CustomTitle(
              text: " ",
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.c912,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
        columnSpacing: 20,
        dataRowHeight: 60,
        rows: getRows(),
      ),
    );
  }

  List<Widget> buildPaginationButtons(
      int totalPages, Function(bool) callBackFunction) {
    List<Widget> buttons = [];
    int start = (bannersViewModel.currentPage ~/ 3) * 3;
    int end = (start + 3).clamp(0, totalPages);
    for (int i = start; i < end; i++) {
      buttons.add(buildPaginationButton(i, (value) {
        if (value) {
          setState(() {
            callBackFunction(value);
          });
        }
      }));
    }

    return buttons;
  }

  Widget buildPaginationButton(
      int pageNumber, Function(bool) callBackFunction) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          if (bannersViewModel.currentPage != pageNumber) {
            Provider.of<BannersViewModel>(context, listen: false)
                .setPage(pageNumber);
            callBackFunction(true);
            Provider.of<BannersViewModel>(context, listen: false)
                .getBanners(
                context, bannersViewModel.currentPage.toString(),false);
          }
        },
        child: Container(
          width: 40,
          height: 40,
          margin: const EdgeInsetsDirectional.only(start: 10),
          padding: const EdgeInsets.only(top: 5),
          decoration: BoxDecoration(
              color: bannersViewModel.currentPage == pageNumber
                  ? AppColors.mainColor.withOpacity(0.1)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(12)),
          child: Center(
            child: CustomTitle(
              text: (pageNumber + 1).toString(),
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: bannersViewModel.currentPage == pageNumber
                  ? AppColors.mainColor
                  : AppColors.c912,
            ),
          ),
        ),
      ),
    );
  }
}
