import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../components/custom_circular_progress_indicator.dart';
import '../../../components/custom_dialog.dart';
import '../../../components/custom_text_filed.dart';
import '../../../components/custom_title.dart';
import '../../../model/product_model/product_model.dart';
import '../../../utilities/colors.dart';
import '../../../utilities/constants.dart';
import '../../../utilities/size_utility.dart';
import '../../../view_model/edit_product_view_model.dart';
import '../../../view_model/general_view_model.dart';
import '../../../view_model/product_view_model.dart';

class ProductsRecord extends StatefulWidget {
  final bool flag;

  const ProductsRecord({super.key, required this.flag});

  @override
  State<ProductsRecord> createState() => _ProductsRecordState();
}

class _ProductsRecordState extends State<ProductsRecord> {
  late final productViewModel = Provider.of<ProductViewModel>(context);

  @override
  Widget build(BuildContext context) {
    int totalRows = productViewModel.totalProducts;
    int totalPages = (totalRows / productViewModel.rowsPerPage).ceil();

    void handlePrevious() {
      setState(() {
        productViewModel.currentPage--;
        productViewModel.firstNum = productViewModel.firstNum - 10;
        productViewModel.lastNum = productViewModel.lastNum - 10;
      });
      if (productViewModel.searchQuery.isNotEmpty) {
        Provider.of<ProductViewModel>(context, listen: false).searchProducts(
            context,
            productViewModel.searchQuery,
            productViewModel.currentPage.toString(),
            false);
      } else {
        Provider.of<ProductViewModel>(context, listen: false).getProducts(
            context, productViewModel.currentPage.toString(), false);
      }
    }

    void handleNext() {
      setState(() {
        productViewModel.currentPage++;
        productViewModel.firstNum = productViewModel.firstNum + 10;
        productViewModel.lastNum = productViewModel.lastNum + 10;
      });
      if (productViewModel.searchQuery.isNotEmpty) {
        Provider.of<ProductViewModel>(context, listen: false).searchProducts(
            context,
            productViewModel.searchQuery,
            productViewModel.currentPage.toString(),
            false);
      } else {
        Provider.of<ProductViewModel>(context, listen: false).getProducts(
            context, productViewModel.currentPage.toString(), false);
      }
    }

    List<DataRow> getRows() {
      List<ProductModel> pageData = productViewModel.products;
      return pageData.mapIndexed((index, product) {
        return DataRow(cells: [
          DataCell(CustomTitle(
            text: (productViewModel.firstNum + index).toString(),
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
                "$baseUrl/uploads/${product.photo}",
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
            CustomTitle(
              text: product.categoryName,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.c016,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          DataCell(
            SizedBox(
              width: getSize(context).width * .1,
              child: CustomTitle(
                text: product.name,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.c016,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ),
          DataCell(
            CustomTitle(
              text: product.brand,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.c016,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          DataCell(
            SizedBox(
              width: getSize(context).width * .05,
              child: CustomTitle(
                text: product.description,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.c016,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ),
          DataCell(
            SizedBox(
              width: getSize(context).width * .05,
              child: CustomTitle(
                text: product.components,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.c016,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ),
          DataCell(
            CustomTitle(
              text: product.quantity,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.c016,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          DataCell(
            CustomTitle(
              text: product.weight,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.c016,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          DataCell(CustomTitle(
            text: "${product.priceBefore} د.ع",
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.c016,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          )),
          DataCell(CustomTitle(
            text: "${product.finalPrice} د.ع",
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
                        Provider.of<EditProductViewModel>(context,
                                listen: false)
                            .clearData();
                        Provider.of<EditProductViewModel>(context,
                                listen: false)
                            .assignData(product);
                        Provider.of<GeneralViewModel>(context, listen: false)
                            .updateSelectedIndex(index: EDITPRODUCT_INDEX);
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
                  child: Tooltip(
                    message: "التحكم في الألوان",
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
                        Provider.of<ProductViewModel>(context, listen: false)
                            .updateSelectedItemId(product.id, product.name );
                        Provider.of<GeneralViewModel>(context, listen: false)
                            .updateSelectedIndex(index: COLORS_INDEX);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColors.mainColor.withOpacity(0.1),
                        ),
                        height: 30,
                        width: 30,
                        child: Center(
                          child: Icon(
                            Icons.color_lens_outlined,
                            color: AppColors.mainColor,
                            size: 20,
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
                                  text: "حذف المنتج",
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.c016,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const CustomTitle(
                                  text:
                                      "هل أنت متأكد أنك تريد حذف هذا المنتج ؟ لا يمكن التراجع عن هذا الإجراء.",
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
                                          onTap: productViewModel.deleting
                                              ? () {}
                                              : () async {
                                                  await Provider.of<
                                                              ProductViewModel>(
                                                          context,
                                                          listen: false)
                                                      .deleteProduct(
                                                    context,
                                                    product.id,
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
                                                              ProductViewModel>(
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
              const Text(
                'المنتجات',
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: widget.flag
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CustomTitle(
                        text: "سجل المنتجات",
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: AppColors.c016,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: getSize(context).width * 0.3,
                            child: CustomTextField(
                              controller: productViewModel.searchController,
                              hintText: 'بحث',
                              hintTextColor: AppColors.c912,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 14),
                              fillColor: AppColors.c991,
                              keyboardType: TextInputType.number,
                              focusBorderColor: Colors.transparent,
                              borderColor: Colors.transparent,
                              suffixIcon: productViewModel
                                      .searchQuery.isNotEmpty
                                  ? Padding(
                                      padding: const EdgeInsetsDirectional.only(
                                          end: 5),
                                      child: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              productViewModel.searchController
                                                  .clear();
                                              productViewModel.searchQuery = "";
                                            });
                                            Provider.of<ProductViewModel>(
                                                    context,
                                                    listen: false)
                                                .getProducts(
                                                    context, "0", true);
                                          },
                                          icon: const Icon(
                                            Icons.close,
                                            size: 25,
                                            color: AppColors.c912,
                                          )),
                                    )
                                  : null,
                              prefixIcon: SizedBox(
                                width: 40,
                                child: Container(
                                  margin: const EdgeInsetsDirectional.all(5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppColors.mainColor,
                                  ),
                                  child: Center(
                                    child: Image.asset(
                                      "assets/icons/search-normal.webp",
                                      scale: 3.5,
                                    ),
                                  ),
                                ),
                              ),
                              onChanged: (val) {
                                setState(() {
                                  productViewModel.searchQuery = val;
                                });
                                if (productViewModel.searchQuery.isNotEmpty) {
                                  Provider.of<ProductViewModel>(context,
                                          listen: false)
                                      .searchProducts(
                                          context,
                                          productViewModel.searchQuery,
                                          "0",
                                          false);
                                } else {
                                  Provider.of<ProductViewModel>(context,
                                          listen: false)
                                      .getProducts(context, "0", true);
                                }
                              },
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
                        text: "سجل المنتجات",
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: AppColors.c016,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              controller: productViewModel.searchController,
                              hintText: 'بحث',
                              hintTextColor: AppColors.c912,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 14),
                              fillColor: AppColors.c991,
                              keyboardType: TextInputType.number,
                              focusBorderColor: Colors.transparent,
                              borderColor: Colors.transparent,
                              suffixIcon: productViewModel
                                      .searchQuery.isNotEmpty
                                  ? Padding(
                                      padding: const EdgeInsetsDirectional.only(
                                          end: 5),
                                      child: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              productViewModel.searchController
                                                  .clear();
                                              productViewModel.searchQuery = "";
                                            });
                                            Provider.of<ProductViewModel>(
                                                    context,
                                                    listen: false)
                                                .getProducts(
                                                    context, "0", true);
                                          },
                                          icon: const Icon(
                                            Icons.close,
                                            size: 25,
                                            color: AppColors.c912,
                                          )),
                                    )
                                  : null,
                              prefixIcon: SizedBox(
                                width: 40,
                                child: Container(
                                  margin: const EdgeInsetsDirectional.all(5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppColors.mainColor,
                                  ),
                                  child: Center(
                                    child: Image.asset(
                                      "assets/icons/search-normal.webp",
                                      scale: 3.5,
                                    ),
                                  ),
                                ),
                              ),
                              onChanged: (val) {
                                setState(() {
                                  productViewModel.searchQuery = val;
                                });
                                if (productViewModel.searchQuery.isNotEmpty) {
                                  Provider.of<ProductViewModel>(context,
                                          listen: false)
                                      .searchProducts(
                                          context,
                                          productViewModel.searchQuery,
                                          "0",
                                          false);
                                } else {
                                  Provider.of<ProductViewModel>(context,
                                          listen: false)
                                      .getProducts(context, "0", true);
                                }
                              },
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
          if (widget.flag || productViewModel.productsEmpty)
            SizedBox(
              width: getSize(context).width,
              child: buildDataTableTheme(getRows),
            )
          else
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: buildDataTableTheme(getRows),
            ),
          if (productViewModel.isProductsLoading)
            const Padding(
              padding: EdgeInsets.only(top: 20),
              child: CustomCircularProgressIndicator(
                  iosSize: 30, color: AppColors.mainColor),
            )
          else if (!productViewModel.productsEmpty)
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
                          text: "${productViewModel.firstNum}",
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
                          text: "${productViewModel.lastNum}",
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
                          onTap: productViewModel.currentPage > 0
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
                                productViewModel.firstNum =
                                    productViewModel.currentPage * 10 + 1;
                                productViewModel.lastNum =
                                    (productViewModel.currentPage + 1) * 10;
                              });
                            }
                          }),
                      if (totalPages > 3)
                        ...buildPaginationButtons(totalPages, (value) {
                          if (value) {
                            setState(() {
                              productViewModel.firstNum =
                                  productViewModel.currentPage * 10 + 1;
                              productViewModel.lastNum =
                                  (productViewModel.currentPage + 1) * 10;
                            });
                          }
                        }),
                      const SizedBox(
                        width: 10,
                      ),
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: productViewModel.currentPage < totalPages - 1
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
          else if (productViewModel.productsEmpty)
            const Padding(
              padding: EdgeInsets.only(top: 20),
              child: CustomTitle(
                text: "لا توجد منتجات",
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
              text: "صورة المنتج",
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.c912,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          DataColumn(
            label: CustomTitle(
              text: "القسم",
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.c912,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          DataColumn(
            label: CustomTitle(
              text: "المنتج",
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.c912,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          DataColumn(
            label: CustomTitle(
              text: "الماركة",
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.c912,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          DataColumn(
            label: CustomTitle(
              text: " الوصف",
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.c912,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          DataColumn(
            label: CustomTitle(
              text: "المكونات",
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.c912,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          DataColumn(
            label: CustomTitle(
              text: "الكمية",
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.c912,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          DataColumn(
            label: CustomTitle(
              text: "الوزن",
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.c912,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          DataColumn(
            label: CustomTitle(
              text: "السعر قبل الخصم",
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.c912,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          DataColumn(
            label: CustomTitle(
              text: "السعر النهائي",
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
    int start = (productViewModel.currentPage ~/ 3) * 3;
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
          if (productViewModel.currentPage != pageNumber) {
            Provider.of<ProductViewModel>(context, listen: false)
                .setPage(pageNumber);
            callBackFunction(true);
            if (productViewModel.searchQuery.isNotEmpty) {
              Provider.of<ProductViewModel>(context, listen: false)
                  .searchProducts(context, productViewModel.searchQuery,
                      productViewModel.currentPage.toString(), false);
            } else {
              Provider.of<ProductViewModel>(context, listen: false).getProducts(
                  context, productViewModel.currentPage.toString(), false);
            }
          }
        },
        child: Container(
          width: 40,
          height: 40,
          margin: const EdgeInsetsDirectional.only(start: 10),
          padding: const EdgeInsets.only(top: 5),
          decoration: BoxDecoration(
              color: productViewModel.currentPage == pageNumber
                  ? AppColors.mainColor.withOpacity(0.1)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(12)),
          child: Center(
            child: CustomTitle(
              text: (pageNumber + 1).toString(),
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: productViewModel.currentPage == pageNumber
                  ? AppColors.mainColor
                  : AppColors.c912,
            ),
          ),
        ),
      ),
    );
  }
}
