import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:menu_dashboard/model/product_variant_model/product_variant_model.dart';
import 'package:menu_dashboard/view/add_prodcut_color/add_product_color.dart';
import 'package:menu_dashboard/view_model/add_product_color_view_model.dart';
import 'package:menu_dashboard/view_model/product_colors_view_model.dart';
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
import '../../../view_model/general_view_model.dart';
import '../../../view_model/product_view_model.dart';

class ProductColorsRecord extends StatefulWidget {
  final bool flag;

  const ProductColorsRecord({super.key, required this.flag});

  @override
  State<ProductColorsRecord> createState() => _ProductColorsRecordState();
}

class _ProductColorsRecordState extends State<ProductColorsRecord> {
  late final productColorsViewModel = Provider.of<ProductColorsViewModel>(context);
  List<DataRow> getRows() {
    List<ProductVariantModel> pageData = productColorsViewModel.productColors;
    return pageData.mapIndexed((index, productColor) {
      return DataRow(cells: [
        DataCell(CustomTitle(
          text: (index + 1).toString(),
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.c016,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        )),
        DataCell(CircleAvatar(
          backgroundColor: Color(int.tryParse(productColor.color.toString()) ?? 0),
        )
        ),
        DataCell(CustomTitle(
          text: productColor.sizes!.isEmpty ? "لا يوجد أحجام" : "${productColor.sizes!.map((e) => e.size)}",
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
                  message: "التحكم في الأحجام",
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
                          .updateSelectedItemId(Provider.of<ProductViewModel>(context,listen: false).selectedProductId, Provider.of<ProductViewModel>(context,listen: false).selectedProductName );

                      Provider.of<ProductColorsViewModel>(context, listen: false)
                          .updateSelectedItem(id: productColor.id);


                      Provider.of<GeneralViewModel>(context, listen: false)
                          .updateSelectedIndex(index: SIZES_INDEX);
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
                          "assets/icons/document.webp",
                          scale: 4.5,
                          color: AppColors.mainColor,
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
                                text: "حذف اللون",
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: AppColors.c016,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const CustomTitle(
                                text:
                                "هل أنت متأكد أنك تريد حذف هذا اللون وجميع الأحجام والأسعار بداخله ؟ لا يمكن التراجع عن هذا الإجراء.",
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
                                        onTap: Provider.of<ProductColorsViewModel>(
                                            context)
                                            .deleting
                                            ? () {}
                                            : () async {
                                          await Provider.of<
                                              ProductColorsViewModel>(
                                              context,
                                              listen: false)
                                              .deleteColor(
                                            context,
                                            Provider.of<ProductViewModel>(context,listen: false).selectedProductId,
                                            productColor.id,
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
                                            child: Provider.of<ProductColorsViewModel>(
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
  @override
  Widget build(BuildContext context) {


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
                'الألوان',
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
                    text: "سجل الألوان",
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
                      Provider.of<AddProductColorViewModel>(context,
                              listen: false)
                          .clearData();
                      Provider.of<AddProductColorViewModel>(context,
                              listen: false)
                          .assignData(Provider.of<ProductViewModel>(context,
                                  listen: false)
                              .selectedProductName);
                      Provider.of<GeneralViewModel>(context, listen: false)
                          .updateSelectedIndex(index: ADDCOLOR_INDEX);
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
                            text: "إضافة لون",
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
                        text: "سجل الألوان",
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
                          Provider.of<AddProductColorViewModel>(context,
                              listen: false)
                              .clearData();
                          Provider.of<AddProductColorViewModel>(context,
                              listen: false)
                              .assignData(Provider.of<ProductViewModel>(context,
                              listen: false)
                              .selectedProductName);
                          Provider.of<GeneralViewModel>(context, listen: false)
                              .updateSelectedIndex(index: ADDCOLOR_INDEX);
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
                                text: "إضافة لون",
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
          if (widget.flag || productColorsViewModel.productColors.isEmpty)
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
          if (productColorsViewModel.isColorsLoading)
            const Padding(
              padding: EdgeInsets.only(top: 20),
              child: CustomCircularProgressIndicator(
                  iosSize: 30, color: AppColors.mainColor),
            )
         else if (productColorsViewModel.productColors.isEmpty)
            const Padding(
              padding: EdgeInsets.only(top: 20),
              child: CustomTitle(
                text: "لا توجد ألوان",
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
              text: "اللون",
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.c912,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          DataColumn(
            label: CustomTitle(
              text: "الأحجام",
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
}