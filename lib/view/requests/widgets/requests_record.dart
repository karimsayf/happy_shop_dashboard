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
import '../../../utilities/validator.dart';
import '../../../view_model/general_view_model.dart';
import '../../../view_model/requests_view_model.dart';

class RequestsRecord extends StatefulWidget {
  final bool flag;

  const RequestsRecord({super.key, required this.flag});

  @override
  State<RequestsRecord> createState() => _RequestsRecordState();
}

class _RequestsRecordState extends State<RequestsRecord> {
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
          .getRequests(context, "status=PROGRESSING", requestViewModel.currentPage.toString(), false);
    }

    void handleNext() {
      setState(() {
        requestViewModel.currentPage++;
        requestViewModel.firstNum = requestViewModel.firstNum + 10;
        requestViewModel.lastNum = requestViewModel.lastNum + 10;
      });
      Provider.of<RequestsViewModel>(context, listen: false)
          .getRequests(context, "status=PROGRESSING", requestViewModel.currentPage.toString(), false);
    }

    List<DataRow> getRows() {
      List<Order> pageData = requestViewModel.requests;
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
              text: request.userPhone,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.c016,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          DataCell(
            CustomTitle(
              text: request.shippingPrice,
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
            GestureDetector(
              onTap: (){
                showCustomDialog(context,content: Text(request.address),contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 20));
              },
              child: const CustomTitle(
                text: 'عرض العنوان',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.mainColor,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
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
          DataCell(
            Row(
              children: [
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: requestViewModel.approving ||
                        requestViewModel.rejecting
                        ? () {}
                        : () {
                      showCustomDialog(context,
                          content: StatefulBuilder(
                            builder: (context, setState) {
                              return SizedBox(
                                width: 400,
                                height: 205,
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: AppColors.mainColor
                                              .withOpacity(0.1),
                                          borderRadius:
                                          BorderRadius.circular(
                                              50)),
                                      child: Container(
                                        margin:
                                        const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            color: AppColors.c555,
                                            borderRadius:
                                            BorderRadius
                                                .circular(50)),
                                        child: Container(
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                              color: AppColors
                                                  .mainColor
                                                  .withOpacity(
                                                  0.11),
                                              borderRadius:
                                              BorderRadius
                                                  .circular(
                                                  50)),
                                          child: Center(
                                            child: Image.asset(
                                              "assets/icons/check-circle.webp",
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
                                      text: "تأكيد الطلب",
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.c016,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const CustomTitle(
                                      text:
                                      "هل أنت متأكد أنك تريد تأكيد هذا الطلب ؟ لا يمكن التراجع عن هذا الإجراء.",
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
                                            cursor:
                                            SystemMouseCursors
                                                .click,
                                            child: GestureDetector(
                                              onTap: () =>
                                                  Navigator.pop(
                                                      context),
                                              child: Container(
                                                height: 50,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(
                                                        12),
                                                    color: AppColors
                                                        .c555,
                                                    border: Border.all(
                                                        width: 1,
                                                        color: AppColors
                                                            .c565)),
                                                child: const Center(
                                                  child:
                                                  CustomTitle(
                                                    text: "إلغاء",
                                                    fontSize: 20,
                                                    fontWeight:
                                                    FontWeight
                                                        .w700,
                                                    color: AppColors
                                                        .c016,
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
                                            cursor:
                                            SystemMouseCursors
                                                .click,
                                            child: GestureDetector(
                                              onTap:
                                              Provider.of<
                                                  RequestsViewModel>(
                                                  context)
                                                  .approving
                                                  ? () {}
                                                  : () async {
                                                await Provider.of<RequestsViewModel>(
                                                    context,
                                                    listen: false)
                                                    .approveOrder(
                                                  context,
                                                  request
                                                      .id,
                                                );
                                              },
                                              child: Container(
                                                height: 50,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(
                                                        12),
                                                    color: AppColors
                                                        .mainColor,
                                                    border: Border.all(
                                                        width: 1,
                                                        color: AppColors
                                                            .mainColor)),
                                                child: Center(
                                                  child: Provider.of<
                                                      RequestsViewModel>(
                                                      context)
                                                      .approving
                                                      ? const CustomCircularProgressIndicator(
                                                      iosSize:
                                                      30,
                                                      color: AppColors
                                                          .c555)
                                                      : const CustomTitle(
                                                    text:
                                                    "تأكيد",
                                                    fontSize:
                                                    20,
                                                    fontWeight:
                                                    FontWeight
                                                        .w700,
                                                    color: AppColors
                                                        .c555,
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
                        borderRadius: BorderRadius.circular(12),
                        color: AppColors.c074,
                      ),
                      height: 45,
                      width: 90,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment:
                        CrossAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.circular(50),
                              color: AppColors.c555,
                            ),
                            height: 20,
                            width: 20,
                            child: const Icon(
                              Icons.check,
                              size: 15,
                              color: AppColors.mainColor,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const CustomTitle(
                            text: "قبول",
                            fontSize: 14,
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
                const SizedBox(
                  width: 10,
                ),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: requestViewModel.rejecting ||
                        requestViewModel.approving
                        ? () {}
                        : () {
                      setState(() {
                        requestViewModel.reasonController.clear();
                      });
                      showCustomDialog(context,
                          content: StatefulBuilder(
                            builder: (context, setState) {
                              return SizedBox(
                                width: 400,
                                height: 205,
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: AppColors.c752
                                              .withOpacity(0.1),
                                          borderRadius:
                                          BorderRadius.circular(
                                              50)),
                                      child: Container(
                                        margin:
                                        const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            color: AppColors.c555,
                                            borderRadius:
                                            BorderRadius.circular(
                                                50)),
                                        child: Container(
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                              color: AppColors.c752
                                                  .withOpacity(0.11),
                                              borderRadius:
                                              BorderRadius
                                                  .circular(50)),
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
                                      text: "رفض الطلب",
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.c016,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const CustomTitle(
                                      text:
                                      "هل أنت متأكد أنك تريد رفض هذا الطلب ؟ لا يمكن التراجع عن هذا الإجراء.",
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
                                            cursor: SystemMouseCursors
                                                .click,
                                            child: GestureDetector(
                                              onTap: () =>
                                                  Navigator.pop(
                                                      context),
                                              child: Container(
                                                height: 50,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(
                                                        12),
                                                    color: AppColors
                                                        .c555,
                                                    border: Border.all(
                                                        width: 1,
                                                        color: AppColors
                                                            .c565)),
                                                child: const Center(
                                                  child: CustomTitle(
                                                    text: "إلغاء",
                                                    fontSize: 20,
                                                    fontWeight:
                                                    FontWeight
                                                        .w700,
                                                    color: AppColors
                                                        .c016,
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
                                            cursor: SystemMouseCursors
                                                .click,
                                            child: GestureDetector(
                                              onTap:
                                              Provider.of<
                                                  RequestsViewModel>(
                                                  context)
                                                  .rejecting
                                                  ? () {}
                                                  : () async {
                                                await Provider.of<RequestsViewModel>(
                                                    context,
                                                    listen:
                                                    false)
                                                    .rejectOrder(
                                                  context,
                                                  request
                                                      .id,
                                                );
                                              },
                                              child: Container(
                                                height: 50,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(
                                                        12),
                                                    color: AppColors
                                                        .c4221,
                                                    border: Border.all(
                                                        width: 1,
                                                        color: AppColors
                                                            .c4221)),
                                                child: Center(
                                                  child: Provider.of<
                                                      RequestsViewModel>(
                                                      context)
                                                      .rejecting
                                                      ? const CustomCircularProgressIndicator(
                                                      iosSize: 30,
                                                      color:
                                                      AppColors
                                                          .c555)
                                                      : const CustomTitle(
                                                    text: "رفض",
                                                    fontSize:
                                                    20,
                                                    fontWeight:
                                                    FontWeight
                                                        .w700,
                                                    color:
                                                    AppColors
                                                        .c555,
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
                        borderRadius: BorderRadius.circular(12),
                        color: AppColors.c999.withOpacity(0.1),
                      ),
                      height: 45,
                      width: 90,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: AppColors.c999,
                            ),
                            height: 20,
                            width: 20,
                            child: const Icon(
                              Icons.close,
                              size: 15,
                              color: AppColors.c555,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const CustomTitle(
                            text: "رفض",
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppColors.c999,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          DataCell(
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Tooltip(
                message: "عرض الطلب",
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
                  onTap: requestViewModel.loadingRequestDetails
                      ? () {}
                      : () async {
                    Provider.of<RequestsViewModel>(context, listen: false)
                        .updateSelectedRecord(index);
                    await Provider.of<RequestsViewModel>(context,
                        listen: false)
                        .getRequestDetails(context, request.products);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.mainColor.withOpacity(0.1),
                    ),
                    height: 30,
                    width: 30,
                    child: Center(
                      child: requestViewModel.loadingRequestDetails &&
                          requestViewModel.selectedRequestRecord == index
                          ? const CustomCircularProgressIndicator(
                          iosSize: 10, color: AppColors.mainColor)
                          : Image.asset(
                        "assets/icons/document.webp",
                        scale: 4.5,
                        color: AppColors.mainColor,
                      ),
                    ),
                  ),
                ),
              ),
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
              const SizedBox(
                width: 10,
              ),
              IconButton(
                onPressed: () {
                  Provider.of<GeneralViewModel>(context, listen: false)
                      .updateSelectedIndex(index: HOME_INDEX);
                },
                icon: const Icon(
                  Icons.home,
                  color: AppColors.mainColor,
                  size: 20,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CustomTitle(
                  text: "سجل الطلبات الحالية ( طلبات تحت المراجعة )",
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.c016,
                ),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      Provider.of<GeneralViewModel>(context, listen: false)
                          .updateSelectedIndex(index: ORDERSHISTORY_INDEX);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.mainColor,
                      ),
                      height: 45,
                      width: 150,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomTitle(
                            text: "سجل الطلبات",
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
                text: "لا توجد طلبات تحت المراجعة",
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
              text: "تليفون العميل",
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.c912,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          DataColumn(
            label: CustomTitle(
              text: "سعر التوصيل",
              fontSize: 14,
              fontWeight: FontWeight.w400,
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
              text: "عنوان التوصيل",
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
                context, "status=PROGRESSING", requestViewModel.currentPage.toString(), false);
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
