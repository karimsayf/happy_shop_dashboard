import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:menu_dashboard/view_model/add_product_color_view_model.dart';
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
class AddProductColorMobileView extends StatefulWidget {
  const AddProductColorMobileView({super.key});

  @override
  State<AddProductColorMobileView> createState() => _AddProductColorMobileViewState();
}

class _AddProductColorMobileViewState extends State<AddProductColorMobileView> {
  late final addProductColorViewModel =
  Provider.of<AddProductColorViewModel>(context);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: AppColors.c555),
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(20),
      child: Form(
        key: addProductColorViewModel.formKey,
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
                      'الألوان',
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
                  'إضافة لون',
                  style: TextStyle(color: Colors.grey, fontSize: 13),
                ),
              ],
            ),
            _buildDivider(),
            const Text(
              'إضافة لون',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
            ),
            _buildDivider(),
            _buildSection(
              title: 'بيانات اللون',
              desc: 'قم برفع تفاصيل اللون',
              children: [
                Row(
                  children: [
                    Expanded(
                        child: Row(
                          children: [
                            Expanded(
                                child: CustomTextField(
                                  controller: addProductColorViewModel.productName,
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
                                  readOnly: true,
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder:(context) => AlertDialog(
                                        title: const Text('اختر اللون'),
                                        content: SingleChildScrollView(
                                          child: ColorPicker(
                                            pickerColor: Colors.white,
                                            onColorChanged: (Color value) {
                                              setState(() {
                                                addProductColorViewModel.color.text = value.value.toString();
                                              });
                                            },

                                          ),
                                        ),
                                        actions: <Widget>[
                                          ElevatedButton(
                                            child: const Text('اختر'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  generalTextFieldValidator:
                                  Validator(context).validateField,
                                  controller: addProductColorViewModel.color.text.isEmpty ? TextEditingController() : TextEditingController(text: Color(int.tryParse(addProductColorViewModel.color.text ) ?? 0).toString()),
                                  suffixIcon: addProductColorViewModel.color.text.isEmpty ? null : CircleAvatar(
                                    radius: 10,
                                    backgroundColor: Color(int.parse(addProductColorViewModel.color.text)),
                                  ),
                                  hintText: 'اللون',
                                  hintTextColor: AppColors.c912,
                                )),
                          ],
                        ))
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),


                Text('يمكنك إضافة أحجام مختلفة ولكل حجم سعر مختلف لكل لون من الألوان التي ستتم إضافتها عن طريق التوجة إلى صفحة المنتج ومن ثم إلى صفحة التحكم في الألوان',style: TextStyle(color: AppColors.c912,),)

              ],
            ),
            _buildDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: addProductColorViewModel.loading
                      ? () {}
                      : () async {
                    await Provider.of<AddProductColorViewModel>(context,
                        listen: false)
                        .addColorAndPrice(
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
                    child: addProductColorViewModel.loading
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
