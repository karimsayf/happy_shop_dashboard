import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:menu_dashboard/view/add_product/add_product.dart';
import 'package:provider/provider.dart';

import '../../../components/custom_circular_progress_indicator.dart';
import '../../../components/custom_text_filed.dart';
import '../../../components/custom_title.dart';
import '../../../components/upload_file_widget.dart';
import '../../../utilities/colors.dart';
import '../../../utilities/constants.dart';
import '../../../utilities/validator.dart';
import '../../../view_model/add_product_view_model.dart';
import '../../../view_model/add_section_view_model.dart';
import '../../../view_model/general_view_model.dart';

class AddProductMobileView extends StatefulWidget {
  const AddProductMobileView({super.key});

  @override
  State<AddProductMobileView> createState() => _AddProductMobileViewState();
}

class _AddProductMobileViewState extends State<AddProductMobileView> {
  late final addProductViewModel = Provider.of<AddProductViewModel>(context);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: AppColors.c555),
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(20),
      child: Form(
        key: addProductViewModel.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const SizedBox(width: 10,),
                IconButton(onPressed: (){
                  Provider.of<GeneralViewModel>(context,listen: false).updateSelectedIndex(index: HOME_INDEX);
                }, icon: const Icon(Icons.home,color: AppColors.mainColor,size: 20,),),
                const Text('/',style: TextStyle(color: AppColors.mainColor,fontSize: 13),),
                const SizedBox(width: 10,),
                InkWell(onTap: (){
                  Provider.of<GeneralViewModel>(context,listen: false).updateSelectedIndex(index: SECTIONS_INDEX);
                },child: const Text('الاقسام',style: TextStyle(color: AppColors.mainColor,fontSize: 13),)),
                const SizedBox(width: 10,),
                const Text('/',style: TextStyle(color: AppColors.mainColor,fontSize: 13),),
                const SizedBox(width: 10,),
                const Text('إضافة منتج',style: TextStyle(color: Colors.grey,fontSize: 13),),
              ],
            ),
            _buildDivider(),
            const Text(
              'إضافة منتج',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
            ),
            _buildDivider(),
            _buildSection(
              title: 'بيانات المنتج',
              desc: 'قم برفع تفاصيل المنتج',
              children: [
                Row(
                  children: [
                    Expanded(
                        child: CustomTextField(
                          controller: addProductViewModel.sectionName,
                          generalTextFieldValidator:
                          Validator(context).validateField,
                          readOnly: true,
                          hintText: 'اسم القسم',
                          hintTextColor: AppColors.c912,
                        )),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                        child: CustomTextField(
                          controller: addProductViewModel.name,
                          generalTextFieldValidator:
                          Validator(context).validateField,
                          hintText: 'اسم المنتج',
                          hintTextColor: AppColors.c912,
                        )),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                        child: CustomTextField(
                          controller: addProductViewModel.description,
                          generalTextFieldValidator: Validator(context).validateField,
                          hintText: 'الوصف',
                          hintTextColor: AppColors.c912,
                        )),

                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                        child: CustomTextField(
                          controller: addProductViewModel.components,
                          generalTextFieldValidator:
                              (p0) {
                            return null;
                          },
                          hintText: 'المكونات (اختياري)',
                          hintTextColor: AppColors.c912,
                        )),

                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                        child: CustomTextField(
                          controller: addProductViewModel.weight,
                          generalTextFieldValidator: (p0) {
                            return null;
                          },

                          hintText: 'الوزن (اختياري)',
                          hintTextColor: AppColors.c912,
                        )),

                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                        child: CustomTextField(
                          controller: addProductViewModel.quantity,
                          keyboardType: TextInputType.number,
                          generalTextFieldValidator:
                              (p0) {
                            return null;
                          },
                          hintText: 'الكمية (اختياري)',
                          suffixIcon: Tooltip(
                            child: Icon(Icons.info_outline),
                            message: 'سيتم اعتماد هذه الكمية كمخزون أساسي للمنتج في حالة (عدم) إضافة أحجام وألوان. \nفي حالة إضافة أحجام وألوان سيتم اعتماد مجموع كميات الأحجام والألوان التي ستقوم بإضافتها.',
                          ),
                          hintTextColor: AppColors.c912,
                        )),

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
                              (p0) {
                            return null;
                          },
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          controller: addProductViewModel.priceBefore,
                          suffixIcon: const Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Text(
                              ' د . ع',
                              style: TextStyle(color: AppColors.c912),
                            ),
                          ),
                          hintText: 'السعر قبل الخصم (اختياري)',
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
                          controller: addProductViewModel.finalPrice,
                          suffixIcon: const Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Text(
                              ' د . ع',
                              style: TextStyle(color: AppColors.c912),
                            ),
                          ),
                          hintText: 'السعر النهائي',
                          hintTextColor: AppColors.c912,
                        )),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                UploadFileWidget(
                  title: "تحميل صورة",
                  file: addProductViewModel.file,
                  setFileOnProvider: (file) {
                    setState(() {
                      addProductViewModel.file = file;
                    });
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Icon(Icons.info_outline,color: AppColors.c912,),
                    SizedBox(width: 10,),
                    Text('يمكنك إضافة ألوان وأحجام بأسعار مختلفة لجميع منتجاتك بعد أضافة المننتج عن طريق التوجه إلى قائمة المنتجات',style: TextStyle(color: AppColors.c912,),),
                  ],
                )

              ],
            ),
            _buildDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: addProductViewModel.loading ? (){} :  () async{
                    await Provider.of<AddProductViewModel>(context,listen: false).addProduct(context);
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.mainColor,
                    ),
                    height: 40,
                    width: 120,
                    child: addProductViewModel.loading? const Center(
                      child: CustomCircularProgressIndicator(
                          iosSize: 30,
                          color: AppColors.c555),
                    ) : const Center(
                      child: CustomTitle(
                        text: 'حفظ البيانات',
                        fontSize: 16,
                        color: AppColors.c555,
                      ),
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
