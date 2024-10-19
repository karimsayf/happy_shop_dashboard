import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:menu_dashboard/view_model/product_colors_view_model.dart';
import 'package:provider/provider.dart';

import '../../../components/custom_circular_progress_indicator.dart';
import '../../../components/custom_text_filed.dart';
import '../../../components/custom_title.dart';
import '../../../utilities/colors.dart';
import '../../../utilities/constants.dart';
import '../../../utilities/validator.dart';
import '../../../view_model/add_product_size_view_model.dart';
import '../../../view_model/general_view_model.dart';
import '../../../view_model/product_view_model.dart';
class AddProductSizeMobileView extends StatefulWidget {
  const AddProductSizeMobileView({super.key});

  @override
  State<AddProductSizeMobileView> createState() => _AddProductSizeMobileViewState();
}

class _AddProductSizeMobileViewState extends State<AddProductSizeMobileView> {
  late final addProductSizeViewModel =
  Provider.of<AddProductSizeViewModel>(context);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: AppColors.c555),
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(20),
      child: Form(
        key: addProductSizeViewModel.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                      style:
                      TextStyle(color: AppColors.mainColor, fontSize: 13),
                    )),
                const SizedBox(
                  width: 10,
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
                          .updateSelectedIndex(index: SIZES_INDEX);
                    },
                    child: const Text(
                      'الاحجام و الاسعار',
                      style:
                      TextStyle(color: AppColors.mainColor, fontSize: 13),
                    )),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  '/',
                  style: TextStyle(color: AppColors.mainColor, fontSize: 13),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  'إضافة حجم وسعر',
                  style: TextStyle(color: Colors.grey, fontSize: 13),
                ),
              ],
            ),
            _buildDivider(),
            const Text(
              'إضافة حجم وسعر',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
            ),
            _buildDivider(),
            _buildSection(
              title: 'بيانات الحجم والسعر',
              desc: 'قم برفع تفاصيل الحجم والسعر',
              children: [
                Row(
                  children: [
                    Expanded(
                        child: Row(
                          children: [
                            Expanded(
                                child: CustomTextField(
                                  controller: addProductSizeViewModel.productName,
                                  generalTextFieldValidator:
                                  Validator(context).validateField,
                                  hintText: 'اسم المنتج',
                                  hintTextColor: AppColors.c912,
                                  readOnly: true,
                                )),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                                child: CustomTextField(
                                  controller: addProductSizeViewModel.name,
                                  generalTextFieldValidator:
                                  Validator(context).validateField,
                                  hintText: 'الحجم',
                                  hintTextColor: AppColors.c912,
                                )),
                          ],
                        ))
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                        child: CustomTextField(
                          controller: addProductSizeViewModel.quantity,
                          generalTextFieldValidator:
                              (p0) {
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          hintText: 'الكمية (اختياري)',
                          suffixIcon: const Tooltip(
                            child: Icon(Icons.info_outline),
                            message: 'سيتم اعتماد هذه الكمية كمخزون أساسي لهذا الحجم',
                          ),
                          hintTextColor: AppColors.c912,
                        )),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                        child: CustomTextField(
                          generalTextFieldValidator:
                          Validator(context).validateNationalId,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          controller: addProductSizeViewModel.price,
                          suffixIcon: const Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Text(
                              ' د . ع',
                              style: TextStyle(color: AppColors.c912),
                            ),
                          ),
                          hintText: 'السعر',
                          hintTextColor: AppColors.c912,
                        )),
                  ],
                ),
              ],
            ),
            _buildDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: addProductSizeViewModel.loading
                      ? () {}
                      : () async {
                    await Provider.of<AddProductSizeViewModel>(context,
                        listen: false)
                        .addSizeAndPrice(
                        context,Provider.of<ProductViewModel>(context,listen: false).selectedProductId,
                        Provider.of<ProductColorsViewModel>(context,listen: false).colorId!

                    );
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.c074,
                    ),
                    height: 40,
                    width: 120,
                    child: addProductSizeViewModel.loading
                        ? const Center(
                      child: CustomCircularProgressIndicator(
                          iosSize: 30, color: AppColors.c555),
                    )
                        : const CustomTitle(
                      text: 'حفظ البيانات',
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  _buildSection(
      {required String title,
        required String desc,
        required List<Widget> children}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(color: AppColors.c016, fontSize: 14),
              ),
              Text(
                desc,
                style: const TextStyle(color: AppColors.c223, fontSize: 12),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Column(
          children: children,
        ),
      ],
    );
  }

  _buildDivider() {
    return const Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Divider(
          color: AppColors.c460,
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
