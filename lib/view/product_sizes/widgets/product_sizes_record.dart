import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../components/custom_circular_progress_indicator.dart';
import '../../../components/custom_dialog.dart';
import '../../../components/custom_title.dart';
import '../../../model/product_size_model/product_size_model.dart';
import '../../../utilities/colors.dart';
import '../../../utilities/constants.dart';
import '../../../utilities/size_utility.dart';
import '../../../view_model/product_sizes_view_model.dart';
import '../../../view_model/add_product_size_view_model.dart';
import '../../../view_model/edit_product_size_view_model.dart';
import '../../../view_model/general_view_model.dart';
import '../../../view_model/product_view_model.dart';

class ProductSizesRecord extends StatefulWidget {
  final bool flag;

  const ProductSizesRecord({super.key, required this.flag});

  @override
  State<ProductSizesRecord> createState() => _ProductSizesRecordState();
}

class _ProductSizesRecordState extends State<ProductSizesRecord> {
  late final productSizeViewModel = Provider.of<ProductSizesViewModel>(context);

  @override
  Widget build(BuildContext context) {
    int totalRows = productSizeViewModel.totalSizes;
    int totalPages = (totalRows / productSizeViewModel.rowsPerPage).ceil();

    void handlePrevious() {
      setState(() {
        productSizeViewModel.currentPage--;
        productSizeViewModel.firstNum = productSizeViewModel.firstNum - 10;
        productSizeViewModel.lastNum = productSizeViewModel.lastNum - 10;
      });
      Provider.of<ProductSizesViewModel>(context, listen: false).getSizes(
          context,
          Provider.of<ProductViewModel>(context, listen: false)
              .selectedProductId,
          productSizeViewModel.currentPage.toString(),
          false);
    }

    void handleNext() {
      setState(() {
        productSizeViewModel.currentPage++;
        productSizeViewModel.firstNum = productSizeViewModel.firstNum + 10;
        productSizeViewModel.lastNum = productSizeViewModel.lastNum + 10;
      });
      Provider.of<ProductSizesViewModel>(context, listen: false).getSizes(
          context,
          Provider.of<ProductViewModel>(context, listen: false)
              .selectedProductId,
          productSizeViewModel.currentPage.toString(),
          false);
    }

    List<DataRow> getRows() {
      List<ProductSizeModel> pageData = productSizeViewModel.productSizes;
      return pageData.mapIndexed((index, productSize) {
        return DataRow(cells: [
          DataCell(CustomTitle(
            text: (productSizeViewModel.firstNum + index).toString(),
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.c016,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          )),
          DataCell(
            CustomTitle(
              text: productSize.size,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.c016,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          DataCell(CustomTitle(
            text: "${productSize.price} د.ع",
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.c016,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          )),
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
                        Provider.of<EditProductSizeViewModel>(context,
                                listen: false)
                            .clearData();
                        Provider.of<EditProductSizeViewModel>(context,
                                listen: false)
                            .assignData(
                            productSize,
                                Provider.of<ProductViewModel>(context,
                                        listen: false)
                                    .selectedProductName);
                        Provider.of<GeneralViewModel>(context, listen: false)
                            .updateSelectedIndex(index: EDITSIZE_INDEX);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColors.mainColor.withOpacity(0.1),
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
                                  text: "حذف الحجم و السعر",
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.c016,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const CustomTitle(
                                  text:
                                      "هل أنت متأكد أنك تريد حذف هذا الحجم و السعر ؟ لا يمكن التراجع عن هذا الإجراء.",
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
                                          onTap: Provider.of<ProductSizesViewModel>(
                                                      context)
                                                  .deleting
                                              ? () {}
                                              : () async {
                                                  await Provider.of<
                                                      ProductSizesViewModel>(
                                                          context,
                                                          listen: false)
                                                      .deleteSize(
                                                    context,
                                                    productSize.id,
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
                                              child: Provider.of<ProductSizesViewModel>(
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
              const Text(
                '/',
                style: TextStyle(color: AppColors.mainColor, fontSize: 13),
              ),
              const SizedBox(
                width: 10,
              ),
              InkWell(
                  onTap: () {
                    Provider.of<GeneralViewModel>(context, listen: false)
                        .updateSelectedIndex(index: PRODUCTS_INDEX);
                  },
                  child: const Text(
                    'المنتجات',
                    style: TextStyle(color: AppColors.mainColor, fontSize: 13),
                  )),
              const Text(
                '/',
                style: TextStyle(color: AppColors.mainColor, fontSize: 13),
              ),
              const SizedBox(
                width: 10,
              ),
              const Text(
                'الاحجام',
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: widget.flag? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: "سجل الاحجام و الاسعار",
                    style: const TextStyle(
                        fontFamily: stcFontStr,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: AppColors.c016,),
                    children: <TextSpan>[
                    const TextSpan(
                        text: " - ",
                        style: TextStyle(
                            fontFamily: stcFontStr,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: AppColors.c016,),
                      ),
                      TextSpan(
                        text: Provider.of<ProductViewModel>(context,
                            listen: false)
                            .selectedProductName,
                        style: const TextStyle(
                            fontFamily: stcFontStr,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: AppColors.c016,),
                      ),
                    ],
                  ),
                ),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      Provider.of<AddProductSizeViewModel>(context,
                              listen: false)
                          .clearData();
                      Provider.of<AddProductSizeViewModel>(context,
                              listen: false)
                          .assignData(Provider.of<ProductViewModel>(context,
                                  listen: false)
                              .selectedProductName);
                      Provider.of<GeneralViewModel>(context, listen: false)
                          .updateSelectedIndex(index: ADDSIZE_INDEX);
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
                            text: "إضافة حجم و سعر",
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
            ) : Column(
              children: [
                Row(
                  children: [
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: "سجل الاحجام و الاسعار",
                        style: const TextStyle(
                          fontFamily: stcFontStr,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: AppColors.c016,),
                        children: <TextSpan>[
                          const TextSpan(
                            text: " - ",
                            style: TextStyle(
                              fontFamily: stcFontStr,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: AppColors.c016,),
                          ),
                          TextSpan(
                            text: Provider.of<ProductViewModel>(context,
                                listen: false)
                                .selectedProductName,
                            style: const TextStyle(
                              fontFamily: stcFontStr,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: AppColors.c016,),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () {
                          Provider.of<AddProductSizeViewModel>(context,
                              listen: false)
                              .clearData();
                          Provider.of<AddProductSizeViewModel>(context,
                              listen: false)
                              .assignData(Provider.of<ProductViewModel>(context,
                              listen: false)
                              .selectedProductName);
                          Provider.of<GeneralViewModel>(context, listen: false)
                              .updateSelectedIndex(index: ADDSIZE_INDEX);
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
                                text: "إضافة حجم و سعر",
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
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          if (widget.flag || productSizeViewModel.sizesEmpty)
            SizedBox(
              width: getSize(context).width,
              child: buildDataTableTheme(getRows),
            )
          else
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: getSize(context).width * 0.9,
                child: buildDataTableTheme(getRows),
              ),
            ),
          if (productSizeViewModel.isSizesLoading)
            const Padding(
              padding: EdgeInsets.only(top: 20),
              child: CustomCircularProgressIndicator(
                  iosSize: 30, color: AppColors.mainColor),
            )
          else if (!productSizeViewModel.sizesEmpty)
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
                          text: "${productSizeViewModel.firstNum}",
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
                          text: "${productSizeViewModel.lastNum}",
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
                          onTap: productSizeViewModel.currentPage > 0
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
                                productSizeViewModel.firstNum =
                                    productSizeViewModel.currentPage * 10 + 1;
                                productSizeViewModel.lastNum =
                                    (productSizeViewModel.currentPage + 1) * 10;
                              });
                            }
                          }),
                      if (totalPages > 3)
                        ...buildPaginationButtons(totalPages, (value) {
                          if (value) {
                            setState(() {
                              productSizeViewModel.firstNum =
                                  productSizeViewModel.currentPage * 10 + 1;
                              productSizeViewModel.lastNum =
                                  (productSizeViewModel.currentPage + 1) * 10;
                            });
                          }
                        }),
                      const SizedBox(
                        width: 10,
                      ),
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: productSizeViewModel.currentPage < totalPages - 1
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
          else if (productSizeViewModel.sizesEmpty)
            const Padding(
              padding: EdgeInsets.only(top: 20),
              child: CustomTitle(
                text: "لا توجد احجام",
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
              text: "الحجم",
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.c912,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          DataColumn(
            label: CustomTitle(
              text: "السعر",
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
    int start = (productSizeViewModel.currentPage ~/ 3) * 3;
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
          if (productSizeViewModel.currentPage != pageNumber) {
            Provider.of<ProductSizesViewModel>(context, listen: false)
                .setPage(pageNumber);
            callBackFunction(true);
            Provider.of<ProductSizesViewModel>(context, listen: false).getSizes(
                context,
                Provider.of<ProductViewModel>(context, listen: false)
                    .selectedProductId,
                productSizeViewModel.currentPage.toString(),
                false);
          }
        },
        child: Container(
          width: 40,
          height: 40,
          margin: const EdgeInsetsDirectional.only(start: 10),
          padding: const EdgeInsets.only(top: 5),
          decoration: BoxDecoration(
              color: productSizeViewModel.currentPage == pageNumber
                  ? AppColors.mainColor.withOpacity(0.1)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(12)),
          child: Center(
            child: CustomTitle(
              text: (pageNumber + 1).toString(),
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: productSizeViewModel.currentPage == pageNumber
                  ? AppColors.mainColor
                  : AppColors.c912,
            ),
          ),
        ),
      ),
    );
  }
}
