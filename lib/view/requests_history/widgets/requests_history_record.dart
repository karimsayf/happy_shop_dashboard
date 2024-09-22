import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../components/custom_circular_progress_indicator.dart';
import '../../../components/custom_dialog.dart';
import '../../../components/custom_text_filed.dart';
import '../../../components/custom_title.dart';
import '../../../model/request_model/request_model.dart';
import '../../../utilities/colors.dart';
import '../../../utilities/constants.dart';
import '../../../utilities/size_utility.dart';
import '../../../view_model/general_view_model.dart';
import '../../../view_model/requests_view_model.dart';

class RequestsHistoryRecord extends StatefulWidget {
  final bool flag;

  const RequestsHistoryRecord({super.key, required this.flag});

  @override
  State<RequestsHistoryRecord> createState() => _RequestsHistoryRecordState();
}

class _RequestsHistoryRecordState extends State<RequestsHistoryRecord> {
  late final requestViewModel = Provider.of<RequestsViewModel>(context);

  @override
  Widget build(BuildContext context) {
    int totalRows = requestViewModel.totalRequests;
    int totalPages = (totalRows / requestViewModel.rowsPerPage).ceil();

    void handlePrevious() {
      setState(() {
        requestViewModel.currentPage--;
        requestViewModel.firstNum = requestViewModel.firstNum - 10;
        requestViewModel.lastNum = requestViewModel.lastNum - 10;
      });
      Provider.of<RequestsViewModel>(context, listen: false)
          .getRequests(context, "DONE&CANCELLED", requestViewModel.currentPage.toString(), false);
    }

    void handleNext() {
      setState(() {
        requestViewModel.currentPage++;
        requestViewModel.firstNum = requestViewModel.firstNum + 10;
        requestViewModel.lastNum = requestViewModel.lastNum + 10;
      });
      Provider.of<RequestsViewModel>(context, listen: false)
          .getRequests(context, "DONE&CANCELLED", requestViewModel.currentPage.toString(), false);
    }

    List<DataRow> getRows() {
      List<RequestModel> pageData = requestViewModel.requests;
      return pageData.mapIndexed((index, request) {
        return DataRow(cells: [
          DataCell(CustomTitle(
            text: (requestViewModel.firstNum + index).toString(),
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.c016,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          )),
          DataCell(
            CustomTitle(
              text: request.captainName,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.c016,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          DataCell(
            CustomTitle(
              text: request.totalQuantity,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.c016,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          DataCell(
            CustomTitle(
              text: request.totalPrice,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.c016,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          DataCell(
            CustomTitle(
              text: request.totalPrice,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.c016,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          DataCell(
              Container(
                height: 30,
                width: 130,
                decoration: BoxDecoration(
                    color: AppColors.c869.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(50),
                    border:
                    Border.all(width: 1, color: AppColors.c869)),
                child: const Center(
                  child: CustomTitle(
                    text: "الطلب تحت المراجعه",
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.c869,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              )
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
              const Text('سجل الطلابات',style: TextStyle(color: AppColors.mainColor,fontSize: 13),)
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomTitle(
                  text: "سجل الطلابات",
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.c016,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          if (widget.flag || requestViewModel.requestsEmpty)
            SizedBox(
              width: getSize(context).width,
              child: buildDataTableTheme(getRows),
            )
          else
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: buildDataTableTheme(getRows),
            ),
          if (requestViewModel.isRequestsLoading)
            const Padding(
              padding: EdgeInsets.only(top: 20),
              child: CustomCircularProgressIndicator(
                  iosSize: 30, color: AppColors.mainColor),
            )
          else if (!requestViewModel.requestsEmpty)
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
                          text: "${requestViewModel.firstNum}",
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
                          text: "${requestViewModel.lastNum}",
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
                          onTap: requestViewModel.currentPage > 0
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
                                requestViewModel.firstNum =
                                    requestViewModel.currentPage * 10 + 1;
                                requestViewModel.lastNum =
                                    (requestViewModel.currentPage + 1) * 10;
                              });
                            }
                          }),
                      if (totalPages > 3)
                        ...buildPaginationButtons(totalPages, (value) {
                          if (value) {
                            setState(() {
                              requestViewModel.firstNum =
                                  requestViewModel.currentPage * 10 + 1;
                              requestViewModel.lastNum =
                                  (requestViewModel.currentPage + 1) * 10;
                            });
                          }
                        }),
                      const SizedBox(
                        width: 10,
                      ),
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: requestViewModel.currentPage < totalPages - 1
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
          else if (requestViewModel.requestsEmpty)
            const Padding(
              padding: EdgeInsets.only(top: 20),
              child: CustomTitle(
                text: "لا توجد طلابات",
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
              text: "اسم الكابتن",
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.c912,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          DataColumn(
            label: CustomTitle(
              text: "الكمية الاجمالية",
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.c912,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          DataColumn(
            label: CustomTitle(
              text: "السعر الاجمالي",
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.c912,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          DataColumn(
            label: CustomTitle(
              text: "الحالة",
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
    int start = (requestViewModel.currentPage ~/ 3) * 3;
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
          if (requestViewModel.currentPage != pageNumber) {
            Provider.of<RequestsViewModel>(context, listen: false)
                .setPage(pageNumber);
            callBackFunction(true);
            Provider.of<RequestsViewModel>(context, listen: false).getRequests(
                context, "DONE&CANCELLED", requestViewModel.currentPage.toString(), false);
          }
        },
        child: Container(
          width: 40,
          height: 40,
          margin: const EdgeInsetsDirectional.only(start: 10),
          padding: const EdgeInsets.only(top: 5),
          decoration: BoxDecoration(
              color: requestViewModel.currentPage == pageNumber
                  ? AppColors.mainColor.withOpacity(0.1)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(12)),
          child: Center(
            child: CustomTitle(
              text: (pageNumber + 1).toString(),
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: requestViewModel.currentPage == pageNumber
                  ? AppColors.mainColor
                  : AppColors.c912,
            ),
          ),
        ),
      ),
    );
  }
}
