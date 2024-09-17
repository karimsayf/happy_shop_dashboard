import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:menu_dashboard/view_model/add_product_size_view_model.dart';
import 'package:menu_dashboard/view_model/product_view_model.dart';
import 'package:provider/provider.dart';

import '../../../components/custom_circular_progress_indicator.dart';
import '../../../components/custom_text_filed.dart';
import '../../../components/custom_title.dart';
import '../../../utilities/colors.dart';
import '../../../utilities/constants.dart';
import '../../../utilities/validator.dart';
import '../../../view_model/edit_product_size_view_model.dart';
import '../../../view_model/general_view_model.dart';

class EditProductSizeDesktopView extends StatefulWidget {
  const EditProductSizeDesktopView({super.key});

  @override
  State<EditProductSizeDesktopView> createState() => _EditProductSizeDesktopViewState();
}

class _EditProductSizeDesktopViewState extends State<EditProductSizeDesktopView> {
  late final editProductSizeViewModel =
      Provider.of<EditProductSizeViewModel>(context);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: AppColors.c555),
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(20),
      child: Form(
        key: editProductSizeViewModel.formKey,
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
                  'تعديل حجم وسعر',
                  style: TextStyle(color: Colors.grey, fontSize: 13),
                ),
              ],
            ),
            _buildDivider(),
            const Text(
              'تعديل حجم وسعر',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
            ),
            _buildDivider(),
            _buildSection(
              title: 'بيانات الحجم والسعر',
              desc: 'قم بتعديل تفاصيل الحجم والسعر',
              children: [
                Row(
                  children: [
                    Expanded(
                        child: Row(
                      children: [
                        Expanded(
                            child: CustomTextField(
                          controller: editProductSizeViewModel.productName,
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
                          onTap: () async{
                            await Provider.of<AddProductSizeViewModel>(context,
                                listen: false)
                                .getMainSizes(
                              context,"0"
                            );
                          },
                          controller: editProductSizeViewModel.name,
                          readOnly: true,
                          generalTextFieldValidator:
                              Validator(context).validateField,
                          hintText: 'اختر الحجم',
                          hintTextColor: AppColors.c912,
                          suffixIcon: editProductSizeViewModel.loadingMainSizes
                              ? const CustomCircularProgressIndicator(
                                  iosSize: 20, color: AppColors.mainColor)
                              : const Icon(
                                  Icons.arrow_drop_down,
                                  color: AppColors.c912,
                                ),
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
                      generalTextFieldValidator:
                          Validator(context).validateNationalId,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      controller: editProductSizeViewModel.price,
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
                  onTap: editProductSizeViewModel.loading
                      ? () {}
                      : () async {
                          await Provider.of<EditProductSizeViewModel>(context,
                                  listen: false)
                              .editSizeAndPrice(
                            context,Provider.of<ProductViewModel>(context,listen: false).selectedProductId
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
                    child: editProductSizeViewModel.loading
                        ? const Center(
                            child: CustomCircularProgressIndicator(
                                iosSize: 30, color: AppColors.c555),
                          )
                        : const CustomTitle(
                            text: 'حفظ اغييرات',
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
    return Row(
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
          width: 60,
        ),
        Expanded(
          child: Column(
            children: children,
          ),
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
